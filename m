Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262780AbVGMUwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262780AbVGMUwO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 16:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbVGMUwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 16:52:09 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:37611 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262443AbVGMUuX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 16:50:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=J0TmmwMKMPa9t8ODBuu+JP8TtcvPctgE3GAjIFVIec0xrpQRqftRMOUdFlPTdUC2OUsXiSBcogsIQDlZCZE1tCmK1ensSujD0HupohZybeRYntvP9PuF95CmPT0CEmtM0vwUGFdsjzjjmUYIZXbEJl8XfsvFCosZd9L5eGG5CsM=
Message-ID: <658687d305071313494faeb53f@mail.gmail.com>
Date: Wed, 13 Jul 2005 22:49:26 +0200
From: Rafi Kosot <rafi972@gmail.com>
Reply-To: Rafi Kosot <rafi972@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Aliased interfaces and binded sockets
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a few aliased interfaces defined on my eth device (eth0:0,
eth0:1, etc.) each alias has a different ip address.
I noticed, that when binding a socket to an ip address (with port=0 -
"don't care"), for outgoing connection, the port number allocated to
the different ip address are distinct (i.e. no overlap). More than
that - when the number of connection exceeds ~60K (in total over all
the aliased interfaces) I get an error EADDRINUSE, though on each one
of the aliased interfaces the number of connections is less than
10,000. It seems like all the aliased interfaces are actually
considered as a single interface!
I looked for the problem in inet section of the kernel, specifically
the function tcp_v4_get_port(..), which is responsible for port
allocation when binding with port=0. Ss far as I understand the ports
are allocated regardless of the interface involved. In other words -
only 64K tcp enpoints are possible, over all interfaces. Is this true?
Has someone noticed the phenomena? Is it possible to bind more than
64K ports over different aliased interfaces?
(Just for the record, I used ulimit -n 128000 so there's no ulimit
problem here).

thanks, Rafi
