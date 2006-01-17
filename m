Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbWAQKNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWAQKNi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 05:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWAQKNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 05:13:38 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:43717 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932375AbWAQKNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 05:13:38 -0500
Date: Tue, 17 Jan 2006 19:13:40 +0900
To: ak@suse.de, linux-kernel@vger.kernel.org
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Christoph Hellwig <hch@infradead.org>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: [PATCH 0/4] compact call trace
Message-ID: <20060117101339.GA19473@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These patches will:

- break the various custom oops-parsers which people have written themselves.
- use common call trace format on x86-64.
- change offset format from hexadecimal to decimal in print_symbol()
- delete symbolsize in call trace in print_symbol().
- print system_utsname.version in oops so that we can doing a
  double check that the oops is matching the vmlinux we're looking at.

Example output:

o Currently we get the following call trace
i386: [<f0ad4c51>] kjournald+0x18c/0x207 [jbd]
x86-64: <ffffffffa008ef6c>{:jbd:kjournald+1030}

o After applied these patches.
i386: [<f0ad4c51>] kjournald+396 [jbd]
x86-64: <ffffffffa008ef6c> kjournald+1030 [jbd]

