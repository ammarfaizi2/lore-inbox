Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751575AbVJ0TrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbVJ0TrN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 15:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbVJ0TrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 15:47:13 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:57553 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751573AbVJ0TrM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 15:47:12 -0400
Subject: one pragma pack vs. many, many __attribute__((packed))
From: Steve French <smfltc@us.ibm.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: IBM - Linux Technology Center
Message-Id: <1130442175.26176.25.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 27 Oct 2005 14:42:55 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems like a big annoyance, but gcc on some platforms (arm) will
generate different code for
	pragma pack(1)
vis the corresponding more verbose alternative ie specifying
	__attribute__((packed)) 
on each structure one by one.  Presumably there are good reasons for why
packing them across the whole file does not mean you can necessarily
read them when they aren't aligned (my imagination is not that good)

Although it makes the code more verbose to individually call out packing
on each structure, I don't see any reasonable alternative that would
work (at least on arm) as I have to deal with structures coming in off
the network that are packed - and in some cases not aligned on 2 or 4
byte boundaries either.   special case parsing them off the wire (as
opposed to accessing them with their structure field names) would be
worse, and copying them into a temp buffer would be worse ... are there
no reasonable magic compile options or pragmas that will have the effect
of attribute__((packed)) without being so verbose?




