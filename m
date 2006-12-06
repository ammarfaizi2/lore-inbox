Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760389AbWLFJu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760389AbWLFJu0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 04:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760387AbWLFJu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 04:50:26 -0500
Received: from iona.labri.fr ([147.210.8.143]:47962 "EHLO iona.labri.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759288AbWLFJuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 04:50:25 -0500
Message-ID: <45769256.1070400@ens-lyon.org>
Date: Wed, 06 Dec 2006 10:50:14 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: "Paul E. McKenney" <paulmck@us.ibm.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: sparse errors in srcu.h
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When running sparse checks on a file that ends up including srcu.h, we
get the following warnings:

    include/linux/srcu.h:52:44: error: undefined identifier 'sp'
    include/linux/srcu.h:52:44: error: bad constant expression
    include/linux/srcu.h:53:56: error: undefined identifier 'sp'
    include/linux/srcu.h:53:56: error: bad constant expression

It seems to be caused by the following lines:

    int srcu_read_lock(struct srcu_struct *sp) __acquires(sp);
    void srcu_read_unlock(struct srcu_struct *sp, int idx) __releases(sp);

which come from the following commit.

    commit 621934ee7ed5b073c7fd638b347e632c53572761
    Author: Paul E. McKenney <paulmck@us.ibm.com>
    Date:   Wed Oct 4 02:17:02 2006 -0700

    [PATCH] srcu-3: RCU variant permitting read-side blocking


I was wondering if there is a way to fix those errors...

Thanks,
Brice

