Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287421AbSA0ATi>; Sat, 26 Jan 2002 19:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287388AbSA0AT3>; Sat, 26 Jan 2002 19:19:29 -0500
Received: from hermes.toad.net ([162.33.130.251]:47554 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S287386AbSA0ATL>;
	Sat, 26 Jan 2002 19:19:11 -0500
Subject: Re: proc_file_read bug?
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 26 Jan 2002 19:19:18 -0500
Message-Id: <1012090760.2575.85.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I discovered that this question is fully answered in
chapter 4 of Linux Device Drivers, 2nd Edition, by
Alessandro Rubini & Jonathan Corbet.  Excellent book.

This "hack" seems to me rather unfortunate.  It makes
a single argument serve two completely different and
not mutually exclusive purposes.  It means that when I
want to override the file offset increment I can't set the
data start position within the buffer, and vice versa.
Overloading "start" in this way also sets an arbitrary
and randomly varying upper limit on the overriding file
offset increment: it can't be equal to or greater than
the address at which the data buffer happens to start.
(It was the seeming irrationality of this that led me
to wonder earlier whether or not the code contained a bug.)

It might have been better to add a new argument to the
read function for the purpose of returning offset increase
overrides.




