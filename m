Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266622AbTAZDTO>; Sat, 25 Jan 2003 22:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266637AbTAZDTO>; Sat, 25 Jan 2003 22:19:14 -0500
Received: from holomorphy.com ([66.224.33.161]:17824 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266622AbTAZDTN>;
	Sat, 25 Jan 2003 22:19:13 -0500
Date: Sat, 25 Jan 2003 19:28:15 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Oleg Drokin <green@namesys.com>, linux-kernel@vger.kernel.org, hch@lst.de,
       jack@suse.cz, mason@suse.com, Stephen Hemminger <shemminger@osdl.org>
Subject: Re: ext2 FS corruption with 2.5.59.
Message-ID: <20030126032815.GA780@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, Oleg Drokin <green@namesys.com>,
	linux-kernel@vger.kernel.org, hch@lst.de, jack@suse.cz,
	mason@suse.com, Stephen Hemminger <shemminger@osdl.org>
References: <20030123153832.A860@namesys.com> <20030124023213.63d93156.akpm@digeo.com> <20030124153929.A894@namesys.com> <20030124225320.5d387993.akpm@digeo.com> <20030125153607.A10590@namesys.com> <20030125190410.7c91e640.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030125190410.7c91e640.akpm@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2003 at 07:04:10PM -0800, Andrew Morton wrote:
+static inline unsigned fr_write_begin(frlock_t *rw)
+{
+	unsigned ret = rw->pre_sequence++;
+	wmb();
+	return ret;
+}	
+
+static inline unsigned fr_write_end(frlock_t *rw) 
+{
+	unsgned ret;
+	wmb();
+	ret = ++(rw->post_sequence);
+	wmb();
+	return ret;
+}

Ticket locks need atomic fetch and increment. These don't look right.


-- wli
