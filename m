Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbVCQSgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbVCQSgg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 13:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbVCQSgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 13:36:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:18617 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262398AbVCQSgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 13:36:19 -0500
From: Steve Grubb <sgrubb@redhat.com>
To: linux-audit@redhat.com
Subject: Re: [patch] Syscall auditing - move "name=" field to the end
Date: Thu, 17 Mar 2005 13:37:01 -0500
User-Agent: KMail/1.7.2
Cc: Chris Wright <chrisw@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
       Ondrej Zary <linux@rainbow-software.org>, linux-kernel@vger.kernel.org
References: <4238A65C.7020908@rainbow-software.org> <1111026301.6833.38.camel@localhost.localdomain> <20050317175703.GE28536@shell0.pdx.osdl.net>
In-Reply-To: <20050317175703.GE28536@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503171337.01433.sgrubb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 March 2005 12:57, Chris Wright wrote:
> Steve, are you working on processing log data, do you have a preference?

Yes, I am working on a utility to process the data. I have 4 comments:

1) Fields that magically appear and dissappear are problematic for fast 
parsing.
2) There should be a way to control what fields the kernel emits. The 
dissappearing fields are what I take to be a stab at message compression. By 
having a mask driven approach and always emitting those fields, we can parse 
faster and have compression.
3) Fields that potentially have a space, tab, or carriage return in them need 
escaping or quoting if they are sent in human readable format.
4) There should be a mode/format status variable so that in the future we can 
tell the kernel to switch to another (binary) format. This way human readable 
records can go to syslog and special apps like the audit daemon can switch to 
another format (binary data ?) which might be more efficient. I haven't spent 
anytime looking at what makes sense for a binary format, nor do we have time 
for that right now. But I'd like to look at that in the future.

-Steve Grubb
