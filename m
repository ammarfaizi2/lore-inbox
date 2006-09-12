Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWILPhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWILPhg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 11:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWILPhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 11:37:36 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:41188 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751332AbWILPhf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 11:37:35 -0400
Message-ID: <4506D438.6090804@fr.ibm.com>
Date: Tue, 12 Sep 2006 17:37:28 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       containers@lists.osdl.org
Subject: Re: [patch -mm] update mq_notify to use a struct pid
References: <45019CC3.2030709@fr.ibm.com>	<m18xktkbli.fsf@ebiederm.dsl.xmission.com>	<450537B6.1020509@fr.ibm.com>	<m1u03eacdc.fsf@ebiederm.dsl.xmission.com>	<45056D3E.6040702@fr.ibm.com>	<m14pve9qip.fsf@ebiederm.dsl.xmission.com>	<4505DADD.4080007@fr.ibm.com> <m1ejuh98vn.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1ejuh98vn.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

[ ... ]

> There is also the case that should not come up with signals where
> we have a pid from a child namespace, that we should also be able to
> compute the pid for.

I don't understand how a signal can come from a child pid namespace ?

> In essence I intend to have a list of pid_namespace, pid_t pairs connected
> to a struct pid that we can look through to find the appropriate pid.

yes, that's the purpose of pid_nr() I guess.

This list would contain in nearly all cases a single pair (current pid
namespace, pid value). It will contain 2 pairs for a task that has unshared
its pid namespace : a pair for the current pid namespace, that needs to
allocated when unshare() is called, and one pair for the ancestor pid
namespace which is already allocated.

Do you see more ?

C.
