Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264104AbTF0KcL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 06:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264146AbTF0KcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 06:32:11 -0400
Received: from [213.171.53.133] ([213.171.53.133]:42762 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id S264104AbTF0KcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 06:32:10 -0400
Date: Fri, 27 Jun 2003 13:47:56 +0400
From: Samium Gromoff <deepfire@ibe.miee.ru>
To: linux-kernel@vger.kernel.org
Cc: sct@redhat.com, akpm@digeo.com, axboe@suse.de
Subject: [BIO] request->flags ambiguity
Message-Id: <20030627134756.4118617e.deepfire@ibe.miee.ru>
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I might just be completely off base, but something struck me lately as odd, and i`d
	like to hear what you folks think about the issue.

	I`m wondering about the ambiguity of the struct request->flags field.

	Is it ok to have a possibility of a request with conflicting meanings attached to it?
	For example REQ_CMD | REQ_PM_SHUTDOWN | REQ_SPECIAL.

	It may be, depending on the implementation, that they are not completely
	conflicting, but its hard to believe that there is zero ambiguity at all.

	If i`m not mistaken this looks as creating opportunities for various subtle bugs.

	Shouldn`t it make more sense to separate request-type-indicator flags
	into a separate unambiguous type field, which would take
	one of the following values:
		- read/write request
		- sense query
		- power control
		- special request

	And not a currently possible combination of all of them, which seem to be the
	current situation.

-- 
regards, Samium Gromoff
