Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbTLDKR5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 05:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbTLDKR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 05:17:57 -0500
Received: from mail.compaq.com ([161.114.1.206]:42505 "EHLO
	ztxmail02.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S262101AbTLDKRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 05:17:55 -0500
Message-ID: <3FCF0A95.3090302@mailandnews.com>
Date: Thu, 04 Dec 2003 15:51:09 +0530
From: Raj <raju@mailandnews.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: fengxj <fengxiangjun@neusoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: system() return different value under 2.4.23 and 2.6.0-test11
References: <00b801c3ba23$a3115670$1801010a@fengxj>
In-Reply-To: <00b801c3ba23$a3115670$1801010a@fengxj>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fengxj wrote:

>-----------------------------
>#include <stdio.h>
>#include <stdlib.h>
>#include <signal.h>
>
>int main(void)
>{
>        int ret;
>
>        signal(SIGCHLD, SIG_IGN);
>
>        ret = system("/bin/date 1>/dev/null");
>        printf("%d\n", ret);
>
>        return 0;
>}
>----------------------------
>
>runs under 2.4.23 with ret = 0,
>but under 2.6.0-test11, ret = -1.
>
>Why?
>
>And when i remove 
>    signal(...)
>it returns the same value 0. 
>  
>

It's happening because of the return values of wait4(). wait4() is
returning -1 in test11 whene SIGCHLD is SIG_IGN'ed.
/Raj

