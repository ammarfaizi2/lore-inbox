Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265152AbUGHCbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265152AbUGHCbZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 22:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265361AbUGHCbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 22:31:25 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:53948 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265152AbUGHCbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 22:31:24 -0400
Date: Wed, 7 Jul 2004 19:32:22 -0700
From: Paul Jackson <pj@sgi.com>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: akpm@osdl.org, viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] task name handling in proc fs
Message-Id: <20040707193222.6604f752.pj@sgi.com>
In-Reply-To: <20040707233532.GD4314@w-mikek2.beaverton.ibm.com>
References: <20040701220510.GA6164@w-mikek2.beaverton.ibm.com>
	<20040701151935.1f61793c.akpm@osdl.org>
	<20040701224215.GC5090@w-mikek2.beaverton.ibm.com>
	<20040701160335.229cfe03.akpm@osdl.org>
	<20040707215246.GB4314@w-mikek2.beaverton.ibm.com>
	<20040707151134.05fc1e07.akpm@osdl.org>
	<20040707233532.GD4314@w-mikek2.beaverton.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

+void set_task_comm(struct task_struct *tsk, char *buf)
+{ ...
+	for(i=0; i<sizeof(tsk->comm); i++) {
+		tsk->comm[i] = *buf++;
+		if (!tsk->comm[i])
+			break;
+	}
+	tsk->comm[sizeof(tsk->comm)-1] = '\0';	/* just in case */

That code fragment looks to me like:

	strlcpy (tsk->comm, buf, sizeof(tsk->comm));

Unless I'm missing something, I'd prefer 'strlcpy'.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
