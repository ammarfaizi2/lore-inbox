Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030422AbWHAIwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030422AbWHAIwD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 04:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030423AbWHAIwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 04:52:03 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:16779 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030422AbWHAIwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 04:52:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=QMJDigZAA8UDyid3LKHpuZ6j6gwkqrX4Lb8OOY/0lR+Ozvm/dwZwccWvTddMdpp7THvuEU2YUvau0GTX+PTMvXYPLFgiA9fTJiu07I4021spGSuOrO1IZXhkqBmOABSu4EI3cWms6ilZyVcO5xiOLIPOrx3J1kKF0hw+lfUOby0=
Message-ID: <44CF1631.3020104@gmail.com>
Date: Tue, 01 Aug 2006 10:51:38 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Heiko Carstens <heiko.carstens@de.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: do { } while (0) question
References: <20060801082109.GB9589@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20060801082109.GB9589@osiris.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko Carstens wrote:
> Hi Andrew,
> 
> your commit e2c2770096b686b4d2456173f53cb50e01aa635c does this:
> 
> ---
> Always use do {} while (0).  Failing to do so can cause subtle compile
> failures or bugs.
> 
> -#define hotcpu_notifier(fn, pri)
> -#define register_hotcpu_notifier(nb)
> -#define unregister_hotcpu_notifier(nb)
> +#define hotcpu_notifier(fn, pri)	do { } while (0)
> +#define register_hotcpu_notifier(nb)	do { } while (0)
> +#define unregister_hotcpu_notifier(nb)	do { } while (0)

#if KILLER == 1
#define MACRO
#else
#define MACRO do { } while (0)
#endif

{
	if (some_condition)
		MACRO

	if_this_is_not_called_you_loose_your_data();
}

How do you want to define KILLER, 0 or 1? I personally choose 0.

regards,
-- 
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
