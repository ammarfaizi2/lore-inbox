Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbWBAJSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWBAJSp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 04:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbWBAJSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 04:18:44 -0500
Received: from frankvm.xs4all.nl ([80.126.170.174]:21902 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S964900AbWBAJR4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 04:17:56 -0500
Date: Wed, 1 Feb 2006 10:17:55 +0100
From: Frank van Maarseveen <frankvm@frankvm.com>
To: linux-kernel@vger.kernel.org
Subject: select(outfd) times out after send(outfd) returns ECONNRESET. bug?
Message-ID: <20060201091755.GA28321@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Saw this (strace -tt -T) on 2.6.14.2 and 2.6.14.6:

12:04:14.180892 accept(3, {sa_family=AF_INET, sin_port=htons(3232), sin_addr=inet_addr("172.17.2.206")}, [16]) = 8 <0.000048>
	...
12:04:14.233478 select(1024, NULL, [8], NULL, {5, 0}) = 1 (out [8], left {5, 0}) <0.000032>
12:04:14.233871 send(8, "\0\252#\307G\355#\307G\355#\307G\355#\307G\355#\307G\355"..., 147, 0) = -1 ECONNRESET (Connection reset by peer) <0.000028>
12:04:14.234109 select(1024, NULL, [8], NULL, {5, 0}) = 0 (Timeout) <4.999045>
12:04:19.233456 select(1024, NULL, [8], NULL, {0, 0}) = 0 (Timeout) <0.000029>
	...
12:04:19.246691 recv(8, "", 147, 0)     = 0 <0.000028>
12:04:19.246888 shutdown(8, 2 /* send and receive */) = -1 ENOTCONN (Transport endpoint is not connected) <0.000017>
12:04:19.247069 close(8)                = 0 <0.000043>


I thought the second (and third) select() call should have returned
immediately, flagging the fd of the reset connection as writable.


-- 
Frank
