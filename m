Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267164AbUJNVqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267164AbUJNVqV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 17:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267409AbUJNVny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 17:43:54 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:14572 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S267164AbUJNVn0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 17:43:26 -0400
Date: Thu, 14 Oct 2004 23:43:22 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux-kernel@vger.kernel.org
Subject: [RFC] improving include header chaos
Message-ID: <Pine.LNX.4.61.0410051749500.7182@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Over the last few years the header situation has become more and more 
fragile. A number of header files define core data structures but also 
define inline functions which reference other data structures.
This often means we have to use macros instead of inline functions only to 
get the whole thing compiled.
A common problem is that inline functions need access to task information, 
the introduction of thread_info shifted this problem only. Now all archs 
are forced to use the same stack layout as i386. ia64 uses a hack to get 
around this.
The only solution I see to actually fix this problem and gain some more 
flexibility is to separate the structure definitions from the inline 
functions.
The following patches separate a few core data structures to other header 
files to demonstrate how it would look like. The final goal is to move the 
task structure into a separate header, so it can be used by various inline 
functions, without the need to use macros or make header mess even worse.
Comments and better ideas how to solve this mess are welcome. Is there 
actually any interest to get this fixed?

bye, Roman
