Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264322AbUD0TvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264322AbUD0TvL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 15:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264301AbUD0TtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 15:49:05 -0400
Received: from email-out1.iomega.com ([147.178.1.82]:23202 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S264315AbUD0TsU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 15:48:20 -0400
Subject: Re: Unable to read UDF fs on a DVD
From: Pat LaVarre <p.lavarre@ieee.org>
To: gerrit.scholl@philips.com
Cc: linux-kernel@vger.kernel.org, linux_udf@hpesjro.fc.hp.com
In-Reply-To: <1083082286.6562.55.camel@patibmrh9>
References: <OFA36FDF30.41353846-ONC1256E83.0039A57A-C1256E83.003B5183@phili
	 ps.com><1083082286.6562.55.camel@patibmrh9>
Content-Type: text/plain;
	charset=UTF-8
Organization: 
Message-Id: <1083095280.6562.88.camel@patibmrh9>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Apr 2004 13:48:00 -0600
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 27 Apr 2004 19:48:19.0694 (UTC) FILETIME=[9734A8E0:01
	C42C90]
X-imss-version: 2.0
X-imss-result: Passed
X-imss-scores: Clean:15.14840 C:49 M:1 S:5 R:5
X-imss-settings: Baseline:1 C:1 M:1 S:1 R:1 (0.0000 0.0000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> compression id 16 (search for "cid:"),
> means that the characters are coded 16 bits per character.
> 
> UDF 2.1.1:
> UDF supports standard Unicode 2.0 except the 'byte-order mark'
> chars #FEFF and #FFFE.
> These characters are coded in OSTA Compressed Unicode format,
> which means 8 bits per char or 16 bits per char.
> If a file identifier contains only unicode chars with al value
> less than #0100, compression id 8 can be used.

Link! Thank you. I clicked thru to:

--- http://www.osta.org/specs/pdf/udf250.pdf
--- (page 17 of 165)

2.1.1 Character Sets

The character set used by UDF for the structures defined in this
document is the ... OSTA CS0 character set ... defined as follows:
...

---

Between your English and their English, I conclude,

I should expect to see 8 or 16 bits per char.  Specifically, when I'm
looking at hex bytes, if I see x08 then thereafter I should see 8 bits
per char thereafter, but if I see x10 then thereafter I should see x10
bits per char.

That sure sounds easier than UTF-8 is, to decode visually from a
hexdump.  For example, I now think, with "OSTA Compressed Unicode", also
known as the "OSTA CS0 character set", the $'\xE2\x82\xAC' x20AC € "EURO
SIGN" will always appear as the plain hex byte pair x 20 AC.

With this much context in place, now the 2004-04-23 guess of "a problem
with 16 bit characters vs 8 bit characters" makes sense.  That guess
says cid 8 maybe works better than cid 16, maybe especially when we need
cid 16 to express a char outside of the x00..FF range.

Pat LaVarre


