Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWHINRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWHINRm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 09:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWHINRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 09:17:41 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:12748 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750763AbWHINRk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 09:17:40 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 4/6] ehea: header files
Date: Wed, 9 Aug 2006 15:17:36 +0200
User-Agent: KMail/1.9.1
Cc: Jan-Bernd Themann <ossthema@de.ibm.com>, netdev <netdev@vger.kernel.org>,
       Thomas Klein <tklein@de.ibm.com>, Christoph Raisch <raisch@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Marcus Eder <meder@de.ibm.com>
References: <44D99F56.7010201@de.ibm.com>
In-Reply-To: <44D99F56.7010201@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608091517.37379.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 August 2006 10:39, Jan-Bernd Themann wrote:
> +extern int ehea_trace_level;
> +
> +#ifdef EHEA_NO_EDEB
> +#define EDEB_P_GENERIC(level, idstring, format, args...) \
> +       while (0 == 1) { \
> +           if(unlikely (level <= ehea_trace_level)) { \
> +                       printk("%s " idstring " "format "\n", \
> +                               __func__, ##args); \
> +         } \
> +       } \
> +
> +#else
> +
> +#define EDEB_P_GENERIC(level,idstring,format,args...) \
> +if (level < KEEP_EDEBS_BELOW) { \
> +       do { \
> +           if(unlikely (level <= ehea_trace_level)) { \
> +                       printk("%s " idstring " "format "\n", \
> +                               __func__, ##args); \
> +         } \
> +       } while (1 == 0); \
> +}
> +#endif
> +
> +#define EDEB(level, format, args...) \
> +        EDEB_P_GENERIC(level, "", format, ##args)
> +
> +#define EDEB_ERR(level, format, args...) \
> +        EDEB_P_GENERIC(level, "EHEA_ERROR", format, ##args)
> +
> +#define EDEB_EN(level, format, args...) \
> +        EDEB_P_GENERIC(level, ">>>", format, ##args)
> +
> +#define EDEB_EX(level, format, args...) \
> +        EDEB_P_GENERIC(level, "<<<", format, ##args)

Please don't invent your own debugging macros. You can either use the
pr_debug/pr_info facility from <linux/kernel.h> or get rid of those
completely. The latter is probably preferred for most of your calls.

	Arnd <><
