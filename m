Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262298AbVCBOCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbVCBOCS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 09:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbVCBOCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 09:02:18 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:48578 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262298AbVCBOCC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 09:02:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=iS6xGwaDCHyu7oGR5EVwxfS+rn6+aJXyeEWv2MIovN2Rh1wstPFJww7/r6qYgvTHAmDJwZJQN73Ave3NqAl3qpht6tmF6LWL7nzgUaic49pfPJAE557MWj7W6K+nKS/Kj2yiUzbW/oLYKFiXXZhPj3lGUqKBtnCHdmrQajuZKTY=
Message-ID: <5a4c581d0503020602130fc630@mail.gmail.com>
Date: Wed, 2 Mar 2005 15:02:01 +0100
From: Alessandro Suardi <alessandro.suardi@gmail.com>
Reply-To: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Jaroslav Kysela <perex@suse.cz>
Subject: Re: smartlink alsa modem problem in 2.6.11
Cc: Michal Semler <cijoml@volny.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0503021358290.1745@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200503021354.38603.cijoml@volny.cz>
	 <Pine.LNX.4.58.0503021358290.1745@pnote.perex-int.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2005 14:01:41 +0100 (CET), Jaroslav Kysela <perex@suse.cz> wrote:
> On Wed, 2 Mar 2005, Michal Semler wrote:
> 
> > Hi,
> >
> > I tried use snd_intel8x0m  with smartlink modem, but without success:
> 
> > Mar  2 13:49:37 notas kernel: codec_semaphore: semaphore is not ready [0x1][0x701300]
> > Mar  2 13:49:37 notas kernel: codec_write 1: semaphore is not ready for
> 
> It's known bug:
> 
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=890
> 
> Have you tried to load "snd-intel8x0m and snd-intel8x0" modules in
> opposite order? Anyway, further discussion should go to this bug
> report...

slmodemd over snd-intel8x0m worked for me last week on 2.6.11-rc4-bk10:

Feb 24 23:19:07 incident chat[2554]: send (ATX3M0^M)
Feb 24 23:19:07 incident chat[2554]: timeout set to 120 seconds
Feb 24 23:19:07 incident chat[2554]: expect (OK)
Feb 24 23:19:07 incident chat[2554]: ^M
Feb 24 23:19:07 incident chat[2554]: ATX3M0^M^M
Feb 24 23:19:07 incident chat[2554]: OK
Feb 24 23:19:07 incident chat[2554]:  -- got it
Feb 24 23:19:07 incident chat[2554]: send (ATDT0,,xxxxxx^M)
Feb 24 23:19:07 incident chat[2554]: expect (CONNECT)
Feb 24 23:19:07 incident chat[2554]: ^M
Feb 24 23:19:07 incident chat[2554]: ATDT0,,xxxxxx^M^M
Feb 24 23:19:07 incident kernel: ALSA sound/pci/intel8x0m.c:401:
codec_semaphore: semaphore is not ready [0x1][0x301300]
Feb 24 23:19:07 incident kernel: ALSA sound/pci/intel8x0m.c:415: codec_write 1:
semaphore is not ready for register 0x54
Feb 24 23:19:52 incident chat[2554]: CONNECT
Feb 24 23:19:52 incident chat[2554]:  -- got it
Feb 24 23:19:52 incident chat[2554]: send (^M)
Feb 24 23:19:52 incident chat[2554]: expect (ogin:)
Feb 24 23:19:52 incident chat[2554]:  28800^M
Feb 24 23:19:58 incident chat[2554]: ^M

[snipped rest of log]

That is - I do get the codec_semaphore messages (though the error code
 is slightly different), but the modem connection works fine.

I have snd-intel8x0m modular while snd-intel8x0 is in-kernel.

--alessandro

  "There is no distance that I don't see
  I do have a will - No limit to my reach"
  
    (Wallflowers, "Empire In My Mind")
