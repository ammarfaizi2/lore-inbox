Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbVLLEeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbVLLEeU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 23:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbVLLEeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 23:34:20 -0500
Received: from rtr.ca ([64.26.128.89]:58545 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751092AbVLLEeT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 23:34:19 -0500
Message-ID: <439CFDCA.2020902@rtr.ca>
Date: Sun, 11 Dec 2005 23:34:18 -0500
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sata_via VT6421 vendor update
References: <439CF781.3080400@pobox.com>
In-Reply-To: <439CF781.3080400@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> +	switch (adev->dma_mode & 0x07) {
> +		case 0:
> +			cfg_byte = 0xee;
> +			break;	
> +		case 1:
> +			cfg_byte = 0xe8;
> +			break;	
> +		case 2:
> +			cfg_byte = 0xe6;
> +			break;	
> +		case 3:
> +			cfg_byte = 0xe4;
> +			break;	
> +		case 4:
> +			cfg_byte = 0xe2;
> +			break;	
> +		case 5:
> +			cfg_byte = 0xe1;
> +			break;	
> +		case 6:
> +			cfg_byte = 0xe0;
> +			break;	
> +		default:
> +			cfg_byte = 0xe0;
> +	}

Mmm.. replace all that with this (?):

	u8 cfg_bytes[8] = {0xee, 0xe8, 0xe6, 0xe4, 0xe2, 0xe1, 0xe0, 0xe0};
	cfg_byte = cfg_bytes[adev->dma_mode & 7];

-ml
