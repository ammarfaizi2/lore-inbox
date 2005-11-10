Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbVKJFpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbVKJFpA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 00:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbVKJFpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 00:45:00 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:36541 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751082AbVKJFpA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 00:45:00 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: "Jan Beulich" <JBeulich@novell.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/39] NLKD - kernel trace buffer access 
In-reply-to: Your message of "Wed, 09 Nov 2005 15:09:13 BST."
             <43721119.76F0.0078.0@novell.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 10 Nov 2005 16:44:52 +1100
Message-ID: <7640.1131601492@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Nov 2005 15:09:13 +0100, 
"Jan Beulich" <JBeulich@novell.com> wrote:
>Debug extension implementation for NLKD to access the kernel trace
>buffer.

 printk.c |  187 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 187 insertions(+)

This is complete overkill in printk.c.  The only change required to
printk is to add a routine which gets the parameters that define the
buffer, see below from KDB.  The rest of the code in your patch belongs
in the debugger, not in printk.

#ifdef	CONFIG_KDB
/* kdb dmesg command needs access to the syslog buffer.  do_syslog() uses locks
 * so it cannot be used during debugging.  Just tell kdb where the start and
 * end of the physical and logical logs are.  This is equivalent to do_syslog(3).
 */
void kdb_syslog_data(char *syslog_data[4])
{
	syslog_data[0] = log_buf;
	syslog_data[1] = log_buf + log_buf_len;
	syslog_data[2] = log_buf + log_end - (logged_chars < log_buf_len ? logged_chars : log_buf_len);
	syslog_data[3] = log_buf + log_end;
}
#endif	/* CONFIG_KDB */

