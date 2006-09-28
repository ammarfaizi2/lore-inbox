Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbWI1VKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWI1VKG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 17:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbWI1VKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 17:10:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:41627 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750928AbWI1VKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 17:10:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OSG3T/BqFfytzBI2egWGe8t7huYgig2YMsSvEJwtBcGmn8AwwRHASyvMkJVdlOdpiREgf0IcHoKQ5LXvQ9ncnxAgcOCVZmtLj0R8qOfD5I7T3xjCqtFDkJaUJtPVl4zFhTb7Lh/xQeh6gi4OHUpaWORaWtN1m+sswlkIPt6yMTo=
Message-ID: <4807377b0609281410p28d445c8mc32e7d2cb71221ab@mail.gmail.com>
Date: Thu, 28 Sep 2006 14:10:02 -0700
From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
To: "Sukadev Bhattiprolu" <sukadev@us.ibm.com>
Subject: Re: Network problem with 2.6.18-mm1 ?
Cc: "Auke Kok" <auke-jan.h.kok@intel.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <20060928185222.GB3352@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060928013724.GA22898@us.ibm.com> <451B2D29.9040306@intel.com>
	 <20060928185222.GB3352@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/06, Sukadev Bhattiprolu <sukadev@us.ibm.com> wrote:
> Thanks. See below for additional info
>
> Auke Kok [auke-jan.h.kok@intel.com] wrote:
> | Sukadev Bhattiprolu wrote:
> | >
> | >I am unable to get networking to work with 2.6.18-mm1 on my system.
> | >
> | >But 2.6.18 kernel on same system works fine. Here is some info about
> | >the system/debug attempts. Attached are the lspci output and config.
> | >
> | >Appreciate any help. Please let me know if you need more info.

It seems you're having interrupt delivery problems or interrupts are
getting lost.
rx_missed_errors indicates frames that were dropped due to the e1000
adapter's fifo getting full and over flowing.
> rx_no_buffer_count: 310
> rx_missed_errors: 5865
rx_no_buffer_count indicates that the driver didn't return buffers to
the hardware soon enough, but the hardware was able to store the
packet (at the time of reception) in the fifo to try again.

Both these indicate to me that there is something wrong with
interrupts.  Maybe interrupt sharing

can you possibly try a back to back connection with another linux box
and run tcpdump on both ends then ping?  it will tell us if traffic is
truely getting out and coming in okay.

also please send output of lspci -vv and cat /proc/interrupts

Jesse
