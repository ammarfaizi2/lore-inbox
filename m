Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbWHKNQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWHKNQn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 09:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWHKNQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 09:16:43 -0400
Received: from tim.rpsys.net ([194.106.48.114]:35798 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1750833AbWHKNQm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 09:16:42 -0400
Subject: Re: [patch 5/6] Convert to use mutexes instead of semaphores
From: Richard Purdie <rpurdie@rpsys.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Michael Hanselmann <linux-kernel@hansmi.ch>,
       "Antonino A. Daplas" <adaplas@pol.net>
In-Reply-To: <d120d5000608110558l3d3a5720i1781f4e90f40579b@mail.gmail.com>
References: <20060811050310.958962036.dtor@insightbb.com>
	 <20060811050611.530817371.dtor@insightbb.com>
	 <d120d5000608110558l3d3a5720i1781f4e90f40579b@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 11 Aug 2006 14:16:09 +0100
Message-Id: <1155302169.19959.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-11 at 08:58 -0400, Dmitry Torokhov wrote:
> On 8/11/06, Dmitry Torokhov <dtor@insightbb.com> wrote:
> > Backlight: convert to use mutexes instead of semaphores
> >
> 
> Apparently I missed that several drivers also use bd->sem so they need
> to be converted too... But what is it with the drivers:
> 
> static void aty128_bl_set_power(struct fb_info *info, int power)
> {
>         mutex_lock(&info->bl_mutex);
>         up(&info->bl_dev->sem);
>         info->bl_dev->props->power = power;
>         __aty128_bl_update_status(info->bl_dev);
>         down(&info->bl_dev->sem);
>         mutex_unlock(&info->bl_mutex);
> }
> 
> Why we are doing up() before down()??? And it is in almost every
> driver that uses backlight... Do I need more coffee? [CC-ing bunch of
> people trying to get an answer...]

It looks totally wrong.

In the archives, there are a number of comments from me questioning
whether that driver needs to touch bl_dev->sem anyway (esp. given the
mutex as well). I never did find out what it was trying to protect
against...

Richard

