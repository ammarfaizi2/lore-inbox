Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbWIOGnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWIOGnW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 02:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWIOGnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 02:43:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:56022 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750874AbWIOGnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 02:43:21 -0400
Subject: Re: __STRICT_ANSI__ checks in headers
From: David Woodhouse <dwmw2@infradead.org>
To: Ismail Donmez <ismail@pardus.org.tr>
Cc: LKML <linux-kernel@vger.kernel.org>, mchehab@infradead.org
In-Reply-To: <200609150901.33644.ismail@pardus.org.tr>
References: <200609150901.33644.ismail@pardus.org.tr>
Content-Type: text/plain
Date: Fri, 15 Sep 2006 07:42:58 +0100
Message-Id: <1158302578.4312.166.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-15 at 09:01 +0300, Ismail Donmez wrote:
> Kernel headers currently uses __STRICT_ANSI__ check before defining a long 
> long variable because ANSI-C doesn't allow long long variables. But this 
> seems to harsh because any project including linux/videodev2.h ( and similar 
> ones ) and using -ansi flag will not compile because some types like __s64 
> will not be defined.

One possible fix is to let videodev2.h use int64_t, and in userspace
they can include <stdint.h>

Another is just to declare videodev2.h incompatible with -ansi, or maybe
just omit 'value64' from the union if __STRICT_ANSI__ is defined, and
replace it with an array of two __s32s.

-- 
dwmw2

