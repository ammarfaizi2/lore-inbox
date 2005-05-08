Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbVEHQVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbVEHQVr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 12:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262892AbVEHQVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 12:21:47 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:60044 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261787AbVEHQVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 12:21:44 -0400
In-Reply-To: <1115524401.5942.13.camel@mulgrave>
References: <4267B5B0.8050608@davyandbeth.com> <loom.20050502T161322-252@post.gmane.org> <20050502144703.GA1882@suse.de> <loom.20050502T221228-244@post.gmane.org>  <20050503141017.GD6115@suse.de> <1115524401.5942.13.camel@mulgrave>
Mime-Version: 1.0 (Apple Message framework v728)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A01CAA87-63E8-46D9-BB64-54C33DB773D4@suse.de>
Cc: Jon Escombe <trial@dresco.co.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Content-Transfer-Encoding: 7bit
From: Jens Axboe <axboe@suse.de>
Subject: Re: Suspend/Resume
Date: Sun, 8 May 2005 18:21:42 +0200
To: James Bottomley <James.Bottomley@SteelEye.com>
X-Mailer: Apple Mail (2.728)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On May 8, 2005, at 5:53 AM, James Bottomley wrote:

> On Tue, 2005-05-03 at 16:10 +0200, Jens Axboe wrote:
>
>> I don't know, depends on what Jeff/James think of this approach.  
>> There
>> are many different way to solve this problem. I let the scsi bus  
>> called
>> suspend/resume for the devices on that bus, and let the scsi host
>> adapter perform any device dependent actions. The pci helpers are  
>> less
>> debatable.
>>
>> Jeff/James? Here's a patch that applies to current git.
>>
>
> The patch looks fine as far as it goes ... however, shouldn't we be
> spinning *internal* suspended drives down as well like IDE does  
> (i.e. at
> least the sd ULD needs to be a party to the suspend)?  Of course  
> this is
> a complete can of worms since we really have no idea which busses are
> internal and which are external, although it might be something that
> userland can determine.

I'm not sure I know what you mean by 'internal suspended drives' that  
aren't spun down? For every device known on the sata "bus", we do the  
standby routine.

There is room for improvement for software suspend, notably it is  
extremely annoying that we cannot tell the difference between  
'freeze' and 'suspend' currently, this adds overhead for suspend-to- 
disk both in time spent and actual drive wear due to an excessive  
spin down+up cycle.

> P.S.  I noticed the gratuitous coding style corrections ...

Heh woops, I usually don't sneak those in with other changes. I think  
this one got in because I actually had another change there that I  
later reverted.

Jens

