Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262283AbVAZXSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbVAZXSO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 18:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262475AbVAZXSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:18:07 -0500
Received: from palrel12.hp.com ([156.153.255.237]:65431 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262295AbVAZRv4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 12:51:56 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16887.55473.889558.825051@napali.hpl.hp.com>
Date: Wed, 26 Jan 2005 09:51:45 -0800
To: Christoph Lameter <clameter@sgi.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andi Kleen <ak@suse.de>, albert@users.sourceforge.net,
       Max Asbock <amax@us.ibm.com>, Anton Blanchard <anton@samba.org>,
       Darren Hart <darren@dvhart.com>, David Mosberger <davidm@hpl.hp.com>,
       "Darrick J. Wong" <djwong@us.ibm.com>,
       George Anzinger <george@mvista.com>, Patricia Gaughen <gone@us.ibm.com>,
       john stultz <johnstul@us.ibm.com>, keith maanthey <kmannth@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       lkml <linux-kernel@vger.kernel.org>, mahuja@us.ibm.com,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Paul Mackerras <paulus@samba.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: [RFC][PATCH] new timeofday arch specific hooks (v. A2)
In-Reply-To: <Pine.LNX.4.58.0501260851450.1852@schroedinger.engr.sgi.com>
References: <OFF640EFCB.17A81893-ON41256F95.0033EA1D-41256F95.00342F11@de.ibm.com>
	<Pine.LNX.4.58.0501260851450.1852@schroedinger.engr.sgi.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 26 Jan 2005 08:52:12 -0800 (PST), Christoph Lameter <clameter@sgi.com> said:

  Christoph> On Wed, 26 Jan 2005, Martin Schwidefsky wrote:
  >> Why not add an if at the start of gettimeofday to check when the
  >> last ntp updates has been done and if it has been too long since
  >> the last time then call ntp_scale ? That way the update isn't
  >> done on every call to gettimeofday and we don't depend on the
  >> regular timer tick.

  Christoph> Because ia64 does not support calling arbitrary C
  Christoph> functions in fastcalls.

However, it can fall back on a heavy-weight syscall easily.  We
already do that on a number of occasions, e.g., if we find a spinlock
already taken.  I think it would be OK to have gettimeofday
occasionally fall back on the heavy-weight version to do NTP magic.

	--david
