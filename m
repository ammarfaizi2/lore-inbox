Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262897AbVEHRJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262897AbVEHRJo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 13:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbVEHRJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 13:09:33 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:47759 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262895AbVEHRJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 13:09:27 -0400
Subject: Re: Suspend/Resume
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Jens Axboe <axboe@suse.de>
Cc: Jon Escombe <trial@dresco.co.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <A01CAA87-63E8-46D9-BB64-54C33DB773D4@suse.de>
References: <4267B5B0.8050608@davyandbeth.com>
	 <loom.20050502T161322-252@post.gmane.org> <20050502144703.GA1882@suse.de>
	 <loom.20050502T221228-244@post.gmane.org>  <20050503141017.GD6115@suse.de>
	 <1115524401.5942.13.camel@mulgrave>
	 <A01CAA87-63E8-46D9-BB64-54C33DB773D4@suse.de>
Content-Type: text/plain
Date: Sun, 08 May 2005 12:08:22 -0500
Message-Id: <1115572102.18977.8.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-05-08 at 18:21 +0200, Jens Axboe wrote:
> On May 8, 2005, at 5:53 AM, James Bottomley wrote:
> > The patch looks fine as far as it goes ... however, shouldn't we be
> > spinning *internal* suspended drives down as well like IDE does  
> > (i.e. at
> > least the sd ULD needs to be a party to the suspend)?  Of course  
> > this is
> > a complete can of worms since we really have no idea which busses are
> > internal and which are external, although it might be something that
> > userland can determine.
> 
> I'm not sure I know what you mean by 'internal suspended drives' that  
> aren't spun down? For every device known on the sata "bus", we do the  
> standby routine.

I mean that at the moment, the suspend code doesn't seem to spin down
any SCSI drives.  However, if it did we'd need to distinguish between
drives that uniquely belong to us (i.e. drives that are internal to the
system) and drives that are external on a shared bus for which we'd
annoy other systems if we spun them down.

> There is room for improvement for software suspend, notably it is  
> extremely annoying that we cannot tell the difference between  
> 'freeze' and 'suspend' currently, this adds overhead for suspend-to- 
> disk both in time spent and actual drive wear due to an excessive  
> spin down+up cycle.
> 
> > P.S.  I noticed the gratuitous coding style corrections ...
> 
> Heh woops, I usually don't sneak those in with other changes. I think  
> this one got in because I actually had another change there that I  
> later reverted.

;-)

James


