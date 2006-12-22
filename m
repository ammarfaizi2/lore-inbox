Return-Path: <linux-kernel-owner+w=401wt.eu-S1752633AbWLVU0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633AbWLVU0F (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 15:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752501AbWLVU0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 15:26:04 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:42226 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633AbWLVU0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 15:26:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Eb/isvscKdXLVYuEQrFy3AFM6/u9mhm3/lhniRNgNrxSyXg3g2pQGnPqYa+6hE8RhIWxuHHd2D99+32FlcaD1+SlMk/LxjeEqCvoSRbATuzhpcRB3je0KFojINKUDpGZnqXvg/pMq/tYaYEMx7PaKae/ChpD5/1YS5QLj6DjUmI=
Message-ID: <d120d5000612221226q40ae235ex251c1bc0c55d42a6@mail.gmail.com>
Date: Fri, 22 Dec 2006 15:26:01 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: [patch 2.6.20-rc1 3/6] input: ads7846 more compatible with hwmon
Cc: nicolas.ferre@rfo.atmel.com, linux-kernel@vger.kernel.org
In-Reply-To: <20061222192322.2BDCA1F0D22@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061222192322.2BDCA1F0D22@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/06, David Brownell <david-b@pacbell.net> wrote:
> Be more compatible with the hwmon framework:
>
>  - Hook up to hwmon
>     * show sensor attrubites only if hwmon is present
>     * otherwise be just a touchscreen
>  - Report voltages per hwmon convention
>     * measure in millivolts
>     * voltages are named in[0-8]_input (ugh)
>     * for 7846 chips, properly range-adjust vBATT/in1_input

There are too many #ifdefs. Please consider creating
ads7846_[un]register_hwmon() and use them in
ads7846_probe()/ads7846_remove(). Split hwmon related attributes into
a separate attribute group and move everything in #ifdef CONFIG_HWMON
block.

> + *
> + * FIXME make external vREF_mV be a module option, and use that as needed...
>  */
> +static const unsigned vREF_mV = 2500;
>

Why don't you make it mdule option right away?

-- 
Dmitry
