Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261765AbULBUul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbULBUul (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 15:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbULBUuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 15:50:40 -0500
Received: from smtp3.akamai.com ([63.116.109.25]:53401 "EHLO smtp3.akamai.com")
	by vger.kernel.org with ESMTP id S261765AbULBUue (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 15:50:34 -0500
Message-ID: <41AF8EC9.2EEA409A@akamai.com>
Date: Thu, 02 Dec 2004 13:53:13 -0800
From: Prasanna Meda <pmeda@akamai.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sys_set/getpriority PRIO_USER semantics fix and optimisation
References: <200412012321.PAA30853@allur.sanmateo.akamai.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pmeda@akamai.com wrote:

> sys_set/getpriority is rewritten in 2.5/2.6, perhaps while transitioning
> to the pid maps.  It has now semantical bug, when uid is zero.  Note

A test case:

#include <stdio.h>
#include <sys/time.h>
#include <sys/resource.h>

int main()
{
        int prio1, prio2, ret, errno;

        /* If root, loose priv. for testing */
        setresuid(237, 237, 237);

        prio1 = getpriority(2, getuid());
        if (setpriority(PRIO_USER, 0, prio1+1) < 0) {
                perror("setprio");
                printf("FAILED!\n");
        }
        else {
                prio2 = getpriority(2, getuid());
                printf("Old prio:%d to new prio:%d\n", prio1, prio2);
                printf((prio1 +1 != prio2)? "FAILED\n":"PASSED\n");
        }
        exit(0);
}

