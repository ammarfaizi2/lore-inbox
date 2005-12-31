Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbVLaJoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbVLaJoL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 04:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbVLaJoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 04:44:11 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:36618 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932117AbVLaJoI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 04:44:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YCt62uKoY7TpYlfWa3s4U80GbYMsHZBrDN9bxNiFRSsA5xada7tNtfos8L5ggL2xVfok7iTVZaV7VBETL2oUK4SV6CGWdSzZ7MELZWTZKQeYO+eemlMs973NBQoC5Hx+HVHwcSKZxGyEN4bjYCm8Dq930o3ieRcw3YR/dAnZD6Q=
Message-ID: <2cd57c900512310144o4aafd05en@mail.gmail.com>
Date: Sat, 31 Dec 2005 17:44:06 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Yi Yang <yang.y.yi@gmail.com>
Subject: Re: [PATCH] Fix user data corrupted by old value return of sysctl
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, gregkh@suse.de,
       akpm@osdl.org
In-Reply-To: <43B64ECA.8090004@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43B4F287.6080307@gmail.com>
	 <2cd57c900512310113i5467a258s@mail.gmail.com>
	 <43B64ECA.8090004@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/12/31, Yi Yang <yang.y.yi@gmail.com>:
> Coywolf Qi Hunt wrote:
> >You didn't set the trailing '\0', I wonder how your printf did work
> >properly ever. You've just been lucky or something.
> >
> >-- Coywolf
> >
> >
> The variable target does it, its value is 0x00000001, so you mustn't
> worry it.
> osname only has 4-bytes space, so if you set '\0' to its tail, a byte
> information will be lost.

I'm worrying more. We should set '\0'. Let the one byte information
lost, the caller deserve that. Actually here printf sees "mylo"+'\01'
if little endian.

Linus, besides fixing bug, your commit certainly breaks userland
compatibility. Please consider.
--
Coywolf Qi Hunt
