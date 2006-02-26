Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWBZXAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWBZXAN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 18:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWBZXAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 18:00:13 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:57682 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932167AbWBZXAL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 18:00:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=V8i3ab9RGPPwQfns6TT+XFjiDT2oI1dQb5HivgFIzXIw5jov+WkodqVooE2bGzejvlkMBeUBCky0VDm/tA3JsZjQTwet5/8QkTEKXL1fh7/RVXRqI6dnh31TZQqnA9TSpvZm4C9yPZoL+udMTDv0MOEcOesCGhi3SymzVT/aZak=
Subject: Re: OOM-killer too aggressive?
From: Chris Largret <largret@gmail.com>
Reply-To: largret@gmail.com
To: Andrew Morton <akpm@osdl.org>
Cc: 76306.1226@compuserve.com, linux-kernel@vger.kernel.org, axboe@suse.de,
       ak@muc.de
In-Reply-To: <20060226133140.4cf05ea5.akpm@osdl.org>
References: <200602260938_MC3-1-B94B-EE2B@compuserve.com>
	 <20060226102152.69728696.akpm@osdl.org>
	 <1140988015.5178.15.camel@shogun.daga.dyndns.org>
	 <20060226133140.4cf05ea5.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 26 Feb 2006 15:00:21 -0800
Message-Id: <1140994821.5522.9.camel@shogun.daga.dyndns.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 Dropline GNOME 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-26 at 13:31 -0800, Andrew Morton wrote:
> > Sorry, this didn't help on my machine. I am running that latest kernel
> > pre-patch (2.6.16-rc4) for testing right now and had to modify the
> > offsets a little. If there's any output that would help, please let me
> > know.
>
> hm, OK.  I suppose we can hit it with the big hammer, but I'd be reluctant
> to merge this patch because it has the potential to hide problems, such as
> the as-yet-unfixed bio-uses-ZONE_DMA one.
> 
> --- devel/mm/page_alloc.c~a	2006-02-26 13:26:56.000000000 -0800
> +++ devel-akpm/mm/page_alloc.c	2006-02-26 13:28:58.000000000 -0800
> @@ -1003,7 +1003,8 @@ rebalance:

I reversed the previous patch before applying this one. If they were
supposed to be used together, let me know.

>From the initial results it looks like the OOM Killer is not being used
now, Unfortunately I can't check with dmesg because right after login is
initiated (but before I get a chance to type anything) there is a
"Kernel BUG" message. This is all that is is printed when a serial
console is in use. If you need the rest of the information, let me know
and I'll see about typing it up.

----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at mm/vmalloc.c:352
invalid opcode: 0000 [1] SMP 
CPU 1 
Modules linked in: snd_pcm_oss snd_mixer_oss md5 ipv6 ipt_recent
ipt_REJECT xt_state xt_tcpudp iptable_filter ip_tables x_tables nfs
lockd nfs_acl sunrpc uhci_hcd r8169 ohci1394 ieee1394 emu10k1_gp
gameport snd_emu10k1 snd_rawmidi snd_ac97_codec snd_ac97_bus snd_pcm
snd_seq_device snd_timer snd_page_alloc snd_util_mem snd_hwdep snd
tda9887 tuner cx8800 cx88xx video_buf ir_common tveeprom compat_ioctl32
v4l1_compat v4l2_common btcx_risc videodev forcedeth usblp ohci_hcd
i2c_nforce2 ehci_hc

--
Chris Largret <http://daga.dyndns.org>

