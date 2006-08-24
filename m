Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751532AbWHXRWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbWHXRWq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 13:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbWHXRWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 13:22:46 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:61322 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751532AbWHXRWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 13:22:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YGV8v+1+Mjk+S/MSW5gHf2IRiCJ8LW3yNAM8CJ8Nxvd1qyZ7TUzAI145lNn5fekurWcuHwJ2JPgeSRXWUwQlIm1rJJl042Mbj6mLzcdO12yvWu6TSiXMVAhp7mN+6ssB0HInrruDMq+imK5UQIvW4MWTeD0wBMZQXYApnlF7/10=
Message-ID: <71a0d6ff0608241022w1101ae2bm1e9dc361f15c137c@mail.gmail.com>
Date: Thu, 24 Aug 2006 21:22:44 +0400
From: "Alexander Shishkin" <alexander.shishckin@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: linux framebuffer ioctls
In-Reply-To: <71a0d6ff0608240548l4a6a3352r6428cf6672a81b64@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <71a0d6ff0608240548l4a6a3352r6428cf6672a81b64@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/06, Alexander Shishkin <alexander.shishckin@gmail.com> wrote:
> I've just stumbled upon a funny issue regarding FBIOGET_FSCREENINFO
To answer my own question. Now that I traced the codepaths of
compat_ioctl, I see that this particular problem has been worked
around by calling do_screeninfo_to_user() which resided in
fs/compat_ioctl.c (as of 2.6.14) and now moved to
drivers/video/fbmem.c where it actually belongs.
The problem in my case was my incorrect implementation of compat_ioctl
method in my driver that called filp->f_op->ioctl() for that matter.
Stupid me.
Just in case someone ever needs this.

-- 
I am free of all prejudices. I hate every one equally.
