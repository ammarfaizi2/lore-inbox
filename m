Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936264AbWLFQN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936264AbWLFQN7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 11:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936335AbWLFQN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 11:13:59 -0500
Received: from belize.chezphil.org ([80.68.91.122]:3834 "EHLO
	belize.chezphil.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936264AbWLFQN6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 11:13:58 -0500
To: "Jan Blunck" <jblunck@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Date: Wed, 06 Dec 2006 16:13:56 +0000
Subject: Re: Subtleties of __attribute__((packed))
Message-ID: <1165421636345@dmwebmail.belize.chezphil.org>
In-Reply-To: <20061206155439.GA6727@hasse.suse.de>
References: <20061206155439.GA6727@hasse.suse.de>
X-Mailer: Decimail Webmail 3alpha14
MIME-Version: 1.0
Content-Type: text/plain; format="flowed"
From: "Phil Endecott" <phil_arcwk_endecott@chezphil.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Blunk wrote:
> Maybe the arm backend is somehow broken. AFAIK (and I verfied it on S390 and
> i386) the alignment shouldn't change.

To see a difference with your example structs you need to compare these two:

struct wibble1 {
   char c;
   struct bar1 b1;
};

struct wibble2 {
   char c;
   struct bar2 b2;
};

struct wibble1 w1 = { 1, { 2, {3,4,5} } };
struct wibble2 w2 = { 1, { 2, {3,4,5} } };

Can you try that with your compilers?  I get:

w1:
	.byte	1
	.space	3    <<<----
	.byte	2
	.4byte	3
	.byte	4
	.space	3
	.4byte	5
	.space	3
	.global	w2
	.align	2
	.type	w2, %object
	.size	w2, 16
w2:
	.byte	1
	.byte	2
	.4byte	3
	.byte	4
	.space	3
	.4byte	5
	.space	2


Phil.




