Return-Path: <linux-kernel-owner+w=401wt.eu-S964867AbXADOdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbXADOdb (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 09:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbXADOdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 09:33:31 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:40203 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964867AbXADOdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 09:33:31 -0500
Message-ID: <459D103E.4080605@drzeus.cx>
Date: Thu, 04 Jan 2007 15:33:34 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.9 (X11/20061223)
MIME-Version: 1.0
To: Philip Langdale <philipl@overt.org>
CC: linux-kernel@vger.kernel.org, Alex Dubov <oakad@yahoo.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.19] mmc: Add support for SDHC cards (Take 4)
References: <459D0C4C.2050401@overt.org>
In-Reply-To: <459D0C4C.2050401@overt.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philip Langdale wrote:
> In the process of developing this patch, we realised that the R6 response definition
> was incorrect and that it should have been identical to R1 (and so should R7).
> Correcting this mistake revealed problems in a couple of host controller drivers that
> relied on the response definitions to be unique. As we need a story for R7, I've
> also fixed up the R6 handling in the affected drivers but I have no idea if it will
> work in practice as I lack the hardware.
>
>   

Do this fix in a separate patch. And cc the relevant maintainers.

> --- /usr/src/linux/drivers/mmc/imxmmc.c	2007-01-01 07:12:02.000000000 -0800
> +++ linux-2.6.19-sdhc/drivers/mmc/imxmmc.c	2007-01-04 05:50:41.000000000 -0800
> @@ -351,9 +360,6 @@
>  	case MMC_RSP_R3: /* short */
>  		cmdat |= CMD_DAT_CONT_RESPONSE_FORMAT_R3;
>  		break;
> -	case MMC_RSP_R6: /* short CRC */
> -		cmdat |= CMD_DAT_CONT_RESPONSE_FORMAT_R6;
> -		break;
>  	default:
>  		break;
>  	}
>   

I think this chunk suffices. Until proven otherwise, regard R6 and R7 as
information the hw does not need to know about. Same thing in tifm_sd.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

