Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312919AbSCZBvx>; Mon, 25 Mar 2002 20:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312918AbSCZBvq>; Mon, 25 Mar 2002 20:51:46 -0500
Received: from lmail.actcom.co.il ([192.114.47.13]:48054 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S312917AbSCZBv3>; Mon, 25 Mar 2002 20:51:29 -0500
Message-Id: <200203260151.g2Q1pdq31035@lmail.actcom.co.il>
Content-Type: text/plain; charset=US-ASCII
From: Itai Nahshon <nahshon@actcom.co.il>
Reply-To: nahshon@actcom.co.il
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Questions: SCSI host adapter detection and registration
Date: Tue, 26 Mar 2002 03:51:27 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have some questions about SCSI host adapter detection
and registration.

I'm looking a the code in scsi/scsi.c, scsi/hosts.c and sample
scsi host adapter drivers.

For simplicity, I assume the host adapter driver is in a module and it's
just loaded (insights about hot-pluggable devices are welcome).

Here are the major steps as I understand them:
1. Module init code calling scsi_register_module() which
    immediately calls scsi_register_hosts().
2. scsi_register_host() calls the driver's detect function.
3. The driver's detect function calls scsi_register() for each
    host (or is it bus?) that it detects.
4. The driver's detect function returns 0 if nothing detected. non
    zero if a host adapter was detected.

My questions:
a. Is any lock held when scsi_register_hosts() is called?
b. scsi_register_hosts() protects the detect call with io_request_lock
    _only_ if use_new_eh_code. Why?
c. If a host was detected, there is a code that checks if next_scsi_host
    was actually incremented... Are there drivers that do not call
    scsi_register() ? Is it for historical or real reason?
    Is it possible (at least in theory) that some driver will change
    next_scsi_host behind our back (hot-pluggable devices)?

Thank you very much,
-- Itai

