Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbTDNSxg (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 14:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbTDNSxf (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 14:53:35 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:29849 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263823AbTDNSxe (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 14:53:34 -0400
Date: Mon, 14 Apr 2003 21:05:14 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Dave Jones <davej@codemonkey.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.67
Message-ID: <20030414190514.GB12740@wohnheim.fh-wedel.de>
References: <20030414173047.GJ10347@wohnheim.fh-wedel.de> <1050338275.25353.93.camel@dhcp22.swansea.linux.org.uk> <20030414174645.GK10347@wohnheim.fh-wedel.de> <20030414182544.GA6866@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030414182544.GA6866@suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 April 2003 19:25:53 +0100, Dave Jones wrote:
> On Mon, Apr 14, 2003 at 07:46:45PM +0200, J?rn Engel wrote:
> 
>  > +/* FIXME: should the below go into some header file? */
>  > +#define PRESTO_COPY_KML_TAIL_BUFSIZE 4096
>  >  struct file * presto_copy_kml_tail(struct presto_file_set *fset,
>  >                                     unsigned long int start)
>  >  {
> 
> so, presto_copy_kml_tail() is only called from
> presto_finish_kml_truncate(), which doesn't seem to be called
> from anywhere. What am I missing here? Or can this whole lot
> just be nuked ?

No idea. I'm just trying to get the kernel into a state where the
kernel stack can be reduced to 4k relatively safely.
As far as intermezzo is concerned, I've never even heard of someone
using it and care accordingly.

> If not, this patch introduces a problem.  You're now
> calling a sleeping function (kmalloc) whilst holding
> a lock according to the comment above presto_finish_kml_truncate()

Ack. Would it be ok to malloc with GFP_ATOMIC then, or would you
propose something different?

Jörn

-- 
ticks = jiffies;
while (ticks == jiffies);
ticks = jiffies;
-- /usr/src/linux/init/main.c
