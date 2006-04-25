Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751527AbWDYVJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbWDYVJa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 17:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbWDYVJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 17:09:30 -0400
Received: from xenotime.net ([66.160.160.81]:21644 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751527AbWDYVJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 17:09:29 -0400
Date: Tue, 25 Apr 2006 14:11:54 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Alex Davis <alex14641@yahoo.com>
Cc: linville@tuxdriver.com, linux-netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] compile error in ieee80211_ioctl.c
Message-Id: <20060425141154.347c5889.rdunlap@xenotime.net>
In-Reply-To: <20060425210450.72120.qmail@web50212.mail.yahoo.com>
References: <20060425210450.72120.qmail@web50212.mail.yahoo.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2006 14:04:50 -0700 (PDT) Alex Davis wrote:

> Hello:
> 
> I sent this patch earlier and got no response, so I'm sending it again.

There was at least one reply, from me.

The third parameter of module_param() is being misused in your patch.
It represents a "permission" value, such as 0, 0444, 0644, etc.
Or you can use existing #defined values for it.

> I cloned git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-dev.git
> last night and got compile errors while compiling net/d80211/ieee80211_ioctl.c
> into a module:
> 
>   CC [M]  net/d80211/ieee80211_ioctl.o
> net/d80211/ieee80211_ioctl.c:33: error: syntax error before string constant
> net/d80211/ieee80211_ioctl.c:33: warning: type defaults to `int' in declaration of `MODULE_PARM'
> net/d80211/ieee80211_ioctl.c:33: warning: function declaration isn't a prototype
> net/d80211/ieee80211_ioctl.c:33: warning: data definition has no type or storage class
> net/d80211/ieee80211_ioctl.c:43: error: syntax error before string constant
> net/d80211/ieee80211_ioctl.c:43: warning: type defaults to `int' in declaration of `MODULE_PARM'
> net/d80211/ieee80211_ioctl.c:43: warning: function declaration isn't a prototype
> net/d80211/ieee80211_ioctl.c:43: warning: data definition has no type or storage class
> make[2]: *** [net/d80211/ieee80211_ioctl.o] Error 1
> make[1]: *** [net/d80211] Error 2
> make: *** [net] Error 2
> 
> This patch fixes it.
> 
> Signed-off-by: Alex Davis <alex14641@yahoo.com>
> 
> diff --git a/net/d80211/ieee80211_ioctl.c b/net/d80211/ieee80211_ioctl.c
> index 42a7abe..4949e52 100644
> --- a/net/d80211/ieee80211_ioctl.c
> +++ b/net/d80211/ieee80211_ioctl.c
> @@ -30,7 +30,7 @@ #include "aes_ccm.h"
>  
>  
>  static int ieee80211_regdom = 0x10; /* FCC */
> -MODULE_PARM(ieee80211_regdom, "i");
> +module_param(ieee80211_regdom, int, 0x10);
>  MODULE_PARM_DESC(ieee80211_regdom, "IEEE 802.11 regulatory domain; 64=MKK");
>  
>  /*
> @@ -40,7 +40,7 @@ MODULE_PARM_DESC(ieee80211_regdom, "IEEE
>   * module.
>   */
>  static int ieee80211_japan_5ghz /* = 0 */;
> -MODULE_PARM(ieee80211_japan_5ghz, "i");
> +module_param(ieee80211_japan_5ghz, int, 0);
>  MODULE_PARM_DESC(ieee80211_japan_5ghz, "Vendor-updated firmware for 5 GHz");

---
~Randy
