Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262197AbUKDMS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbUKDMS5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 07:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262173AbUKDMS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 07:18:57 -0500
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:60614 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262186AbUKDMR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 07:17:58 -0500
Date: Thu, 4 Nov 2004 13:17:55 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: CULPRIT FOUND (was: 2.6.9 network regression killing amanda)
Message-ID: <20041104121755.GA17144@merlin.emma.line.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
References: <20041020191203.GA14356@merlin.emma.line.org> <20041020142420.0d513191.akpm@osdl.org> <20041020221034.GA10414@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020221034.GA10414@merlin.emma.line.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found the issue that was breaking my amanda dumps.

Using the ip_conntrack_amanda component (either compiled into the kernel
or loaded as a module) corrupts the packets by replacing one LF by a NUL
byte. This in consequence invalidates the checksum, causing the packets
to be discarded.

Workaround: unload ip_conntrack_amanda.

Fix: I've sent a patch in separate mail, Subject:
[BK PATCH] Fix ip_conntrack_amanda data corruption bug that breaks amanda dumps

-- 
Matthias Andree
