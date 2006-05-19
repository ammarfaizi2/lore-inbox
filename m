Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbWESS2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWESS2M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 14:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWESS2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 14:28:12 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:13658 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932466AbWESS2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 14:28:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:x-mimeole:thread-index:in-reply-to;
        b=mm164CKjHfP3ZWJhpWvKlYGTy36Z0BvPQNM8O04lOhrR3P5w2u/Tx7Wcbq1CXUpl49YUGDcjZOuscGZHz7RbuEFtC7bBIWIA3OF/LwU9kDVIX8ty/h8DEddFyy6ahj6ngq71kL26KlQZ/H+1eSXBcvDBPV054ho0Uq6wdeipEo0=
From: "Hua Zhong" <hzhong@gmail.com>
To: "'Eric W. Biederman'" <ebiederm@xmission.com>,
       "'Andrew Morton'" <akpm@osdl.org>
Cc: "'Herbert Poetzl'" <herbert@13thfloor.at>, <serue@us.ibm.com>,
       <linux-kernel@vger.kernel.org>, <dev@sw.ru>, <devel@openvz.org>,
       <sam@vilain.net>, <xemul@sw.ru>, <haveblue@us.ibm.com>,
       <clg@fr.ibm.com>
Subject: RE: [PATCH 0/9] namespaces: Introduction
Date: Fri, 19 May 2006 11:28:08 -0700
Message-ID: <008201c67b71$fb938db0$493d010a@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Thread-Index: AcZ7YaZgQRGsMNDMR7ScSgTtCqnONAAECAEQ
In-Reply-To: <m1iro2yo7f.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> snapshot/restart/migration worry me.  If they require 
> complete serialisation of complex kernel data structures then 
> we have a problem, because it means that any time anyone 
> changes such a structure they need to update (and test) the 
> serialisation.

Checkpoint/Restart/Migration could be very complicated if done at OS level (per process/process group/or any subset of an OS). But
it is much simpler if done on virtual machine level (VMWare/Xen) because there is a natural and clear boundary, and doesn't get
affected if the OS kernel internal changes.

It's good to see some progress in supporting virtualization in Linux, but as Andrew put it, some big decisions need to be made
up-front. One big question is actually how many virtualization technologies Linux should support? Particularly, does it need to
support both OS-level virtualization and VM-level virtualization? And why? And to what degree?

My gut feeling is that the VM approach seems much cleaner and modular, without touching too many areas (except some low-level ones)
inside the kernel and in general very well separated. There are two reasons:

1. In a VM system, the architecture is very simple. Hypervisor and guest OS kernel have clear boundaries and interfaces to
communicate, and OS in general pretty much doesn't need to care if it's running on native hardware or inside a VM. So it adds very
little maintanence burden to the kernel developers (and if there is, it's relatively well understood).

2. Hardware support. With more virtualization built into CPU, VM is only going to get simper.

It seems at least the VM approach is much less risky. It might be helpful if someone could explain why we need both.

Hua

