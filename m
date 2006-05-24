Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbWEXU36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWEXU36 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 16:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbWEXU36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 16:29:58 -0400
Received: from hera.kernel.org ([140.211.167.34]:55222 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750938AbWEXU35 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 16:29:57 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 4096 byte limit to /proc/PID/environ ?
Date: Wed, 24 May 2006 13:29:53 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e52fo1$uv5$1@terminus.zytor.com>
References: <4474B7DB.8000304@moving-picture.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1148502593 31718 127.0.0.1 (24 May 2006 20:29:53 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 24 May 2006 20:29:53 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think this is the wrong approach.

Many of these should probably be converted to seq_file, but in the
particular case of environ, the right approach is to observe the fact
that reading environ is just like reading /proc/PID/mem, except:

 a. the access restrictions are less strict, and
 b. there is a range restriction, which needs to be enforced, and
 c. there is an offset.

Pretty much, take the guts from /proc/PID/mem and generalize it
slightly, and you have the code that can run either /proc/PID/mem or
/proc/PID/environ.

	-hpa
