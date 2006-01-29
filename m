Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWA2Xe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWA2Xe6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 18:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbWA2Xe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 18:34:58 -0500
Received: from xproxy.gmail.com ([66.249.82.204]:13220 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932082AbWA2Xe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 18:34:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=HODGhh/+u7x3Xur0CQ8Hm6cHaIvjMG4aZWsgBMztj842gSc5j+kSkk9e7U9p/sSuwMje3lV1KG1d0GfIlmrap8gXEIOYFBhGE3IU1N+387jBDaHkS7C6ZzsOxW2Zsvt7/gVwD5YRPyYUu5ilvRgnSGJTZ2b6v/FK9yiDtALytqk=
Message-ID: <43DD510E.9090404@gmail.com>
Date: Mon, 30 Jan 2006 07:34:38 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>, benh@kernel.crashing.org,
       linux-kernel@hansmi.ch
Subject: Re: [Linux-fbdev-devel] [PATCH] fbdev: Fix usage of blank value passed
 to fb_blank
References: <20060127231314.GA28324@hansmi.ch> <20060127.204645.96477793.davem@davemloft.net> <43DB0839.6010703@gmail.com> <200601282106.21664.ioe-lkml@rameria.de> <43DC25EB.1040005@gmail.com> <20060129144228.GA22425@sci.fi>
In-Reply-To: <20060129144228.GA22425@sci.fi>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Syrjälä wrote:
> On Sun, Jan 29, 2006 at 10:18:19AM +0800, Antonino A. Daplas wrote:
>> diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
>> index d2dede6..5bed0fb 100644
>> --- a/drivers/video/fbmem.c
>> +++ b/drivers/video/fbmem.c
>> @@ -843,6 +843,19 @@ fb_blank(struct fb_info *info, int blank
>>  {	
>>   	int ret = -EINVAL;
>>  
>> +	/*
>> +	 * The framebuffer core supports 5 blanking levels (FB_BLANK), whereas
>> +	 * VESA defined only 4.  The extra level, FB_BLANK_NORMAL, is a
>> +	 * console invention and is not related to power management.
>> +	 * Unfortunately, fb_blank callers, especially X, pass VESA constants
>> +	 * leading to undefined behavior.
> 
> Since when? X.Org uses numbers 0,2,3,4 which match the FB_BLANK 
> constants not the VESA constants.
> 

How about if we silently convert FB_BLANK_NORMAL requests to
FB_BLANK_VSYNC_SUSPEND, would that work?

Tony

PS: Soft blanking is very difficult, if not impossible, to
implement correctly kernel-side, so we can either fail (current
code), silently fail but return success, or convert to the next
blank level.
