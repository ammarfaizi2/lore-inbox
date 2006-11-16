Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423146AbWKPKHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423146AbWKPKHy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 05:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423223AbWKPKHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 05:07:54 -0500
Received: from qb-out-0506.google.com ([72.14.204.228]:39087 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1423146AbWKPKHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 05:07:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=toRnZx1Kfp4PyxdPZFStmOsBncbGGINzVlzj5OUZGLkMsUo5tFDvwOvT9WwTMovS9N0uuIbNkekej4JxVdWvXnPF8vBITtDQjSTQyH1Wo2qPdJkOeqrXep/malk5mMHWb1d6WPxLztkYmDV7XZCN430jrjiBuxG039CDLdmfFbo=
Message-ID: <40f31dec0611160207hcfd5069hc7763d1e99cccd7c@mail.gmail.com>
Date: Thu, 16 Nov 2006 12:07:51 +0200
From: "Nick Kossifidis" <mickflemm@gmail.com>
To: "Michael Renzmann" <madwifi@nospam.otaku42.de>
Subject: Re: [Madwifi-devel] ANNOUNCE: SFLC helps developers assess ar5k (enabling free Atheros HAL)
Cc: "Michael Buesch" <mb@bu3sch.de>, "Pavel Roskin" <proski@gnu.org>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       madwifi-devel@lists.sourceforge.net, lwn@lwn.net,
       "John W. Linville" <linville@tuxdriver.com>
In-Reply-To: <455BF908.6090006@otaku42.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061115031025.GH3451@tuxdriver.com>
	 <20061115192054.GA10009@tuxdriver.com> <1163619541.19111.6.camel@dv>
	 <200611152102.26681.mb@bu3sch.de> <455BF908.6090006@otaku42.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just in case you want to experiment, i have a working port of ar5k
that works on madwifi-old before the BSD - HEAD merge...

well i'm no good programmer (yet), i did what i could (i'm sure those
define macros are nasty for most people :P) and hope that helps...

you can git clone from the following link

rsync://rsync.ath-driver.org/gnumonks_users/mb/openhal.git

I'm working with the following madwifi revision...
svn checkout http://svn.madwifi.org/branches/madwifi-old -r 1142 madwifi

Don't forget to remove the ending ) in line 175 at
net80211/ieee80211_radiotap.h ;-)

Also you'll need to do some modifications to make it work with newer
kernel versions (MODULE_PARM stuff in if_ath.c)...

diff -Naurp madwifi-openhal/ath/if_ath.c madwifi-openhal-fixed/ath/if_ath.c
--- madwifi-openhal/ath/if_ath.c	2005-06-24 06:41:22.000000000 -0400
+++ madwifi-openhal-fixed/ath/if_ath.c	2006-08-04 14:49:38.000000000 -0400
@@ -245,13 +245,20 @@ enum {
 #endif

 static	int countrycode = -1;
-MODULE_PARM(countrycode, "i");
-MODULE_PARM_DESC(countrycode, "Override default country code");
 static	int outdoor = -1;
-MODULE_PARM(outdoor, "i");
-MODULE_PARM_DESC(outdoor, "Enable/disable outdoor use");
 static	int xchanmode = -1;
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,52))
+MODULE_PARM(countrycode, "i");
+MODULE_PARM(outdoor, "i");
 MODULE_PARM(xchanmode, "i");
+#else
+#include <linux/moduleparam.h>
+module_param(countrycode, int, 0);
+module_param(outdoor, int, 0);
+module_param(xchanmode, int, 0);
+#endif
+MODULE_PARM_DESC(countrycode, "Override default country code");
+MODULE_PARM_DESC(outdoor, "Enable/disable outdoor use");
 MODULE_PARM_DESC(xchanmode, "Enable/disable extended channel mode");

 int

See README for more details


I haven't looked much the MadWiFi code since then, perhaps you can
help in making ar5k work with newer madwifi versions + improve it's
functionality to help both linux and OpenBSD.

(The name OpenHAL came from John Bicket's initial port)


Happy coding ;-)
Nick

2006/11/16, Michael Renzmann <madwifi@nospam.otaku42.de>:
> Hi.
>
> Michael Buesch wrote:
> > Well, it never worked for me. But I gave up trying about
> > half a year ago. But maybe it's just stupid me. ;)
>
> Well, we have various support channels (an IRC channel besides two
> mailing lists, for example) that you are welcome to make use of in case
> of problems :)
>
> Bye, Mike
>
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Madwifi-devel mailing list
> Madwifi-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/madwifi-devel
>
