Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751886AbWISRur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbWISRur (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 13:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbWISRur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 13:50:47 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:52573 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751886AbWISRur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 13:50:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EapWAto7A3OBd0/iUfcojh8wyRLn6o4WtmNjAljFNL52ZQL7MKHzcJwIMQ8yeiIEKg+khyrrk/MDqzvIchQwE9/Ed0QtXcVHuOThknq1shtXPiN92t29JpBi52D0ttP7cDipYcPzqMWq6oPIZ+t2nFPg9+kAWjvVucc5eNtBfjs=
Message-ID: <69304d110609191050w777a5c48ibe84bc0e3ce65df3@mail.gmail.com>
Date: Tue, 19 Sep 2006 19:50:46 +0200
From: "Antonio Vargas" <windenntw@gmail.com>
To: "Ludovic Drolez" <ldrolez@linbox.com>
Subject: Re: [PATCH] sched.c: Be a bit more conservative in SMP
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <loom.20060919T155900-330@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200609031541.39984.subdino2004@yahoo.fr>
	 <200609031910.57259.vincent.plr@wanadoo.fr>
	 <200609070130.53995.vincent.plr@wanadoo.fr>
	 <loom.20060919T155900-330@post.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/06, Ludovic Drolez <ldrolez@linbox.com> wrote:
> Vincent Pelletier <vincent.plr <at> wanadoo.fr> writes:
> > I'll do some tests soon to see which version gives better performance at a
> > higher level than just process migration cost - if different at all.
>
> I think that your patch should improve the performance because process
> migrations are expensive (cache miss) and should be avoided when not
> really necessary.
>
> Cheers,
>
>   Ludovic.
>

A variant on this theme would be (not tested or somewhat, just a
random idea for considering):

1. find if the process is a cpu-hog, if not then ignore

2. find somehow how much time has this process on it's current cpu

3. then, instead of always substracting 1 from th current load on the
current cpu, substract for example 1...0 when running from 0 to 60
seconds... this way cpu hogs would only rotate slowly?

in code:

number_to_sub_from_queue_load = (256 - min(256,
time_from_last_change_of_cpu)) >> 8;

somehow managing to get fixedpoint loadlevels on the runqueues would
make this work better....


-- 
Greetz, Antonio Vargas aka winden of network

http://network.amigascne.org/
windNOenSPAMntw@gmail.com
thesameasabove@amigascne.org

Every day, every year
you have to work
you have to study
you have to scene.
