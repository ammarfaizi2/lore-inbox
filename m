Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWHKM7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWHKM7G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 08:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWHKM7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 08:59:06 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:13580 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932221AbWHKM66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 08:58:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rjdtWTAAMh/z2jGOc5vN3/ZnnUJ34wbHwahSrPnv1AhYVgumBlGtvE+jVuPG08twkZlbvPK+cmsv+RH0PstIY9wgD4gMSnUnhm5zwsfnEK0HJCqpFA6q5DQoA/2dkPYNUGFmxYYfEPLFedYKTL/f3Rvjo8keiO3hsDJNqIKLmBU=
Message-ID: <d120d5000608110558l3d3a5720i1781f4e90f40579b@mail.gmail.com>
Date: Fri, 11 Aug 2006 08:58:53 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Richard Purdie" <rpurdie@rpsys.net>
Subject: Re: [patch 5/6] Convert to use mutexes instead of semaphores
Cc: LKML <linux-kernel@vger.kernel.org>,
       "Michael Hanselmann" <linux-kernel@hansmi.ch>,
       "Antonino A. Daplas" <adaplas@pol.net>
In-Reply-To: <20060811050611.530817371.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060811050310.958962036.dtor@insightbb.com>
	 <20060811050611.530817371.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/06, Dmitry Torokhov <dtor@insightbb.com> wrote:
> Backlight: convert to use mutexes instead of semaphores
>

Apparently I missed that several drivers also use bd->sem so they need
to be converted too... But what is it with the drivers:

static void aty128_bl_set_power(struct fb_info *info, int power)
{
        mutex_lock(&info->bl_mutex);
        up(&info->bl_dev->sem);
        info->bl_dev->props->power = power;
        __aty128_bl_update_status(info->bl_dev);
        down(&info->bl_dev->sem);
        mutex_unlock(&info->bl_mutex);
}

Why we are doing up() before down()??? And it is in almost every
driver that uses backlight... Do I need more coffee? [CC-ing bunch of
people trying to get an answer...]

-- 
Dmitry
