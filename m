Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbWCQLLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWCQLLk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 06:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWCQLLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 06:11:40 -0500
Received: from nproxy.gmail.com ([64.233.182.195]:37663 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751394AbWCQLLk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 06:11:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gaGesUeNT72iB8QVyVZU0FUkN56Z4ZTf4LKoLGwYOVtm8ldbcz1sANVkgJtB6GJhV7ouiwzx50Zg0CKtryfRB4RpKa1zfkCPwQO4LbniFxDFNvBRo37rl+fS8V4pttdHe4GyqK2lLcewNZzJAsJADBj7wy7Q/UbHsYfDbMhPdYk=
Message-ID: <661de9470603170311o146f0a63m9f866817b4525ff0@mail.gmail.com>
Date: Fri, 17 Mar 2006 16:41:38 +0530
From: "Balbir Singh" <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
To: prasanna@in.ibm.com
Subject: Re: Kernel Oops-jprobe
Cc: "emist emist" <emistz@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060317095858.GA855@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060317025519.GA32497@in.ibm.com>
	 <661de9470603170131j7580d8ccr9927a600a7184ef3@mail.gmail.com>
	 <20060317095858.GA855@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I think the handler should first copy_from_user().
>
> User must not call copy_from_user() in the handler, since preemption is
> disabled and the copy_from_user might cause a page fault that might
> sleep if the user page is not in the memory. Although the latest patch
> posted on lkml tries to fixup the exception, it may some
> times not succeed and the data collected might be incorrect.
>
Yes, you are right. I forgot about the probe handler requirements. In
that case you need to come up with your own trick to get the user
space data. Also look at/use systemtap.

Balbir
