Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbWEVXpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWEVXpM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 19:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWEVXpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 19:45:12 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:9660 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751306AbWEVXpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 19:45:11 -0400
Subject: Question re: __mlog_cpu_guess in fs/ocfs2/cluster/masklog.h
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: mark.fasheh@oracle.com, kurt.hackel@oracle.com
Content-Type: text/plain
Date: Mon, 22 May 2006 19:45:06 -0400
Message-Id: <1148341507.2556.104.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am puzzled by this code and comment:

/*
 * smp_processor_id() "helpfully" screams when called outside preemptible
 * regions in current kernels.  sles doesn't have the variants that don't
 * scream.  just do this instead of trying to guess which we're building
 * against.. *sigh*.
 */
#define __mlog_cpu_guess ({             \
        unsigned long _cpu = get_cpu(); \
        put_cpu();                      \
        _cpu;                           \
})

First I think you mean "inside preemptible regions".  Second, it screams
because it's a bug to call smp_processor_id() from preemptible code!

Am I missing something?

Lee

