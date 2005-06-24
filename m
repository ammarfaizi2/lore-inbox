Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263183AbVFXXrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263183AbVFXXrO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 19:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263169AbVFXXoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 19:44:24 -0400
Received: from jynx.3ti.be ([217.22.63.77]:33681 "EHLO horsea.3ti.be")
	by vger.kernel.org with ESMTP id S263151AbVFXXnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 19:43:47 -0400
Date: Sat, 25 Jun 2005 01:43:40 +0200 (CEST)
From: Dag Wieers <dag@wieers.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Block device layer freezing block device access ? (follow-up)
In-Reply-To: <Pine.LNX.4.63.0506200437290.3085@horsea.3ti.be>
Message-ID: <Pine.LNX.4.63.0506250138290.9497@horsea.3ti.be>
References: <Pine.LNX.4.63.0506200209000.3085@horsea.3ti.be>
 <Pine.LNX.4.63.0506200437290.3085@horsea.3ti.be>
User-Agent: Mutt/1.2.5.1i
X-Mailer: Ximian Evolution 1.0.5
Organization: 3TI Web Hosting Services
X-Extra: We know Linux is the best. It can do infinite loops in five seconds. - Linus Torvalds
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jun 2005, Dag Wieers wrote:

> On Mon, 20 Jun 2005, Dag Wieers wrote:
> 
> > 
> > I've got an (apparently) broken disk. But I see the following behaviour.
> > The kernel reads the partition table without problems and then has some 
> > unrecoverable errors.
> > 
> > After the system has booted, the disk has become inaccessible, but it 
> > appears that the driver/block device layer has decided to make the disk 
> > inaccessible, as I can't even access the partition table anymore (which 
> > was previously accessible during boot).
> 
> Using Knoppix instead of a Fedora rescue image, I was able to do a reverse 
> dd_rescue and already recovered 25GB from the 160GB disk, it now is having 
> some (155 now) bad blocks, but I hope it recovers from that (as it already 
> managed to do that after the first 55 bad blocks).
> 
> Still I'm wondering why on boot it is able to read the partition table, 
> but not when booted. Knoppix has the same issue.

For those wondering what was causing this. After recovering the whole 
disk, this is what ddrescue could not recover:

	Bad region size 32768 at position 4096
	Bad region size 4096 at position 49152
	Bad region size 57344 at position 32083968
	...

Now, the kernel was able to read the first 512 bytes fine. But fdisk 
apparently reads at first 512 bytes and then reads 8kB. Since this second 
read fails it bails out. (I'm not sure why it does a second 8kB read 
though).

But that's why the partition table was actually fine (and the kernel did 
not complain about it) but the disk apparently seemed more dead than it 
actually was. Well, not that the disk is useful now, but at least I 
recovered most of it.

	Total of 103 good regions representing 160058684 kB. 99.983%
	Total of 100 bad regions representing 10020 kB. 0.006%
	Total of 3 dangling regions representing 17824 kB. 0.011%
	Total of 0 unknown regions representing 0 kB. 0.000%

	Total of 20040 bad blocks

fsck had a lot of issues, but everything I still required that wasn't on 
my last backup has been restored succesfully.

Kind regards,
--   dag wieers,  dag@wieers.com,  http://dag.wieers.com/   --
[all I want is a warm bed and a kind word and unlimited power]
