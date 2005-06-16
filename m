Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbVFPECO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbVFPECO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 00:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVFPECO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 00:02:14 -0400
Received: from smtp829.mail.sc5.yahoo.com ([66.163.171.16]:3256 "HELO
	smtp829.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261729AbVFPECA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 00:02:00 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.12-rc3] Adds persistent entryies using request_firmware_nowaitManuel Estrada Sainz <ranty@debian.org>,
Date: Wed, 15 Jun 2005 23:01:48 -0500
User-Agent: KMail/1.8.1
Cc: Abhay Salunke <Abhay_Salunke@dell.com>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, matt_domsch@dell.com
References: <20050616003414.GA1814@littleblue.us.dell.com>
In-Reply-To: <20050616003414.GA1814@littleblue.us.dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506152301.48963.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 June 2005 19:34, Abhay Salunke wrote:
> This is a patch to make the /sys/class/firmware entries persistent. 
> This has been tested with dell_rbu; dell_rbu was modified to not call
> request_firmware_nowait again form the callback function. 
> 
> The new mechanism to make the entries persistent is as follows
> 1> echo 0 > /sys/class/firmware/timeout
> 2> echo 2 > /sys/class/firmware/xxx/loading
> 
> step 1 prevents timeout to occur , step 2 makes the entry xxx persistent
> 
> if we want to remove persistence then do this
> ech0 -2 > /sys/class/firmware/xxx/loading
> 

Hi,

I have the following issues with the patch:

- since "persistency" (or rather repeat loading) is controlled from
  userspace, drivers don't have control over it. This way every user
  of request_firmware_nowait has to be ready to process more than one
  firmware load.

- There is no way to "cancel" firmware request from the driver. You
  will not be able to safely unload users of request_firmware_nowait().
  Since loader is rearming you can't use firmware handler function to
  signal when request has been processed.

I think that such re-arming reqests are much better implemented in
individual drivers.

-- 
Dmitry
