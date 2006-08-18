Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030267AbWHROgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbWHROgJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 10:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030425AbWHROgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 10:36:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:51840 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030267AbWHROgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 10:36:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AuvheCP5k50ZtL4+ynX/ITls2eGQFL2/6Du2hrxZhi+b/TTUwoUG5tvGSNPh8wZ/8ghlQZUxgDILUp7PasomgU923MDyNvhT9rT4X4cOh8AaEL+//7vTwfe9RVeJp6XUhNgJpFLj+Kv+8x0hfMCrw9BoqdNc52dq4frixRvxHB8=
Message-ID: <d120d5000608180736s73964217kd30a79168a761ea8@mail.gmail.com>
Date: Fri, 18 Aug 2006 10:36:06 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: Question about handling return value of device_create_file function
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <6bffcb0e0608180618m13153b26yb8c3151c30265be@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6bffcb0e0608180618m13153b26yb8c3151c30265be@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> Hi,
>
> I have noticed that sparse generates a lot of "ignoring return value
> of 'device_create_file'" warnings.
>
> (cat sparse.txt | grep -c "device_create_file"
> 1231 :)
>
> I want to fix this warnings, but I'm wondering how to properly handle
> return value of device_create_file function.
>
> The shortest way.
>
> int foo()
> {
>        int error;
>
>        [..]
>
>        error = device_create_file(&bar, &bas)
>
>        if (error)
>                return error;
> }
>
> A bit longer way.
>
> int foo()
> {
>        int error;
>
>        [..]
>
>        error = device_create_file(&bar, &bas)
>
>        if (error) {
>                subsystem_remove_device(bar);
>                return error;
>        }
> }
>

Normally you should use 2nd form, especially when foo is a
module_init(foo) as you do not want to have a half-registered device
without supporting code in kernel.

-- 
Dmitry
