Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbWA3QbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWA3QbQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 11:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWA3QbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 11:31:16 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:25298 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932366AbWA3QbP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 11:31:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tyX3Uscmuykh6kpCD7lIlzNBzT2JBgKcjrH/Wcxwnnn1bderw4BeSYIp0r8Le73f+IWrKq2edL6P/c3vtECHenhsas0J7cUsR1TWzoAJfwDGpBcKPH1Qrye22Y7PT9BX9GH4VLnI3t+qUwDv38Al0jdBdVoGEH15jGLwzcs6LLM=
Message-ID: <787b0d920601300831j99fae82n5d4a5d94f99baafd@mail.gmail.com>
Date: Mon, 30 Jan 2006 11:31:14 -0500
From: Albert Cahalan <acahalan@gmail.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux try #2 [ was: Re: CD writing in future Linux (stirring up a hornets' nest) ]
Cc: mrmacman_g4@mac.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jengelh@linux01.gwdg.de, bzolnier@gmail.com
In-Reply-To: <43DE3A99.nail16ZK1MAWN@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com>
	 <43DCA097.nailGPD11GI11@burner>
	 <20060129112613.GA29356@merlin.emma.line.org>
	 <Pine.LNX.4.61.0601292139080.2596@yvahk01.tjqt.qr>
	 <43DD2A8A.nailGVQ115GOP@burner>
	 <787b0d920601291328k52191977h3778a7c833d640f2@mail.gmail.com>
	 <43DE3A99.nail16ZK1MAWN@burner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> Albert Cahalan <acahalan@gmail.com> wrote:
>
> > Let's address the second bug first. Linux provides full
> > bus number and LUN info for all block devices. You get it
> > like this:
> >
> > struct stat sbuf;
> > stat("/dev/hdc", &sbuf);
> > int bus = sbuf.st_mode>>12;
> > int target = major(sbuf.st_rdev);
> > int lun = minor(sbuf.st_rdev);
>
> Now tell me how to match this with information from /dev/sg*

You do the obvious, scanning /dev to find the device file.

You can map from names to numbers (like DNS does for IP) and
back from numbers to names (like reverse DNS does).

If you need to map from /dev/hd* to /dev/sg*, then you have
found a bug. Explain what must be added to /dev/hd* so that
you don't need to go messing with /dev/sg* anymore.

The name /dev/hd* is not the high-level interface. It's the device
name, used by both high-level and low-level interfaces. It alone
is the non-kernel way to refer to the device. (inside the kernel
you just get a pointer, and the dev_t assists in translation)
