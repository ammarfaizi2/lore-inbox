Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129423AbQLGVFX>; Thu, 7 Dec 2000 16:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129428AbQLGVFO>; Thu, 7 Dec 2000 16:05:14 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:24077 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S129423AbQLGVE4>; Thu, 7 Dec 2000 16:04:56 -0500
Message-ID: <3A2FF454.373A5142@holly-springs.nc.us>
Date: Thu, 07 Dec 2000 15:34:28 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre21 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: 2.2.18 vs 2.4.0 proc_fs.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why is 2.2.18 proc_fs.c different than both 2.2.17 and 2.4.0? Cox, would
you accept a patch that makes 2.2.18 define create_proc_info_entry and
related functions the same way that 2.4.0 does?

2.2.17:
does not define this

2.2.18:
#define create_proc_info_entry(n, m, b, g) \
	{ \
		struct proc_dir_entry *r = create_proc_entry(n, m, b); \
		if (r) r->get_info = g; \
	}

2.4.0:
extern inline struct proc_dir_entry *create_proc_info_entry(const char
*name,
	mode_t mode, struct proc_dir_entry *base, get_info_t *get_info)
{
	struct proc_dir_entry *res=create_proc_entry(name,mode,base);
	if (res) res->get_info=get_info;
	return res;
}
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
