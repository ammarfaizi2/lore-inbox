Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbWCaUjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWCaUjM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 15:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWCaUjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 15:39:11 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:23175 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932275AbWCaUjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 15:39:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:thread-index:x-mimeole;
        b=TEQhkraHqkki6aIuaqqazgpFCrrc8hLaSmpmNuPylaHavtyPmNV6fzQhCLKecfdnhZ3huKcvVdEaZL84kWlXnUDp6d16kMFklBRaeZgQSqYZgF6hZJIS9A7pz4VBCV8Be90BSBWEfkc0iazHBeivwFE7SAtCTb8sGBDGMgPKVes=
From: "Hua Zhong" <hzhong@gmail.com>
To: "'Linus Torvalds'" <torvalds@osdl.org>, "'Jens Axboe'" <axboe@suse.de>
Cc: "'Ingo Molnar'" <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       <akpm@osdl.org>
Subject: RE: [PATCH] splice support #2
Date: Fri, 31 Mar 2006 12:38:52 -0800
Message-ID: <000001c65503$207d8e40$853d010a@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <Pine.LNX.4.64.0603300905270.27203@g5.osdl.org>
Thread-Index: AcZUHhEkS9jh0QzgQI2dJm53hsPMowA5Gdsg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

> The 4th reason is "tee". Again, you _could_ perhaps do "tee" 
> without the pipe, but it would be a total nightmare. Now, tee 
> isn't that common, but it does happen, and in particular it 
> happens a lot with certain streaming content.

If I understand correctly:

splice is one fd in, one fd out
tee is one fd in, two fd out (and I'd assume the "one fd in" would always be
a pipe)

How about one fd in, N fd out? Do you then stack the tee calls using
temporary pipes?

i.e., if N=3, then we'd have:

pipe(fd_tmp_pipe);
tee(fd_in, fd_out1, fd_tmp_pipe[0];
tee(fd_tmp_pipe[1], fd_out2, fd_out3);

Basically, N-2 temporary pipes would be required.

Is this the intention?

Hua


