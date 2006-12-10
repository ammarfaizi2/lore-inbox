Return-Path: <linux-kernel-owner+w=401wt.eu-S1759953AbWLJDW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759953AbWLJDW5 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 22:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759961AbWLJDW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 22:22:57 -0500
Received: from liaag1ag.mx.compuserve.com ([149.174.40.33]:47865 "EHLO
	liaag1ag.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759953AbWLJDW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 22:22:56 -0500
Date: Sat, 9 Dec 2006 22:18:45 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: -mm merge plans for 2.6.20
To: Steve French <smfltc@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel <linux-kernel@vger.kernel.org>,
       Shirish S Pargaonkar <shirishp@us.ibm.com>, simo <simo@samba.org>,
       Jeremy Allison <jra@samba.org>, linux-cifs-client@lists.samba.org
Message-ID: <200612092220_MC3-1-D483-92AE@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <4579AFA5.90003@us.ibm.com>

On Fri, 08 Dec 2006 12:32:05 -0600, Steve French wrote:

> smbfs deprecation is ok but there are a few things to consider:

> 2) minor holes in backlevel server (OS/2 and Windows 9x/WindowsME) support

How well-tested is the plaintext password support?

By default the /proc/fs/cifs/SecurityFlags setting is 0x7 (MAY_SIGN |
MAY_NTLM | MAYNTLMV2). Trying to connect to an old Samba server
with that, I got a message that the server requested a plain text
password but client support was disabled.

After changing the flags to 0x37 (adding MAY_LANMAN | MAY_PLNTXT),
I got "invalid password." Looking at the ethereal traces, it seemed
that the password was being sent as encrypted Unicode, and the only
way to make it connect was to set the flags to 0x30.

Also, the client doesn't automatically pick up the domain name from
smb.conf like smbfs does.

-- 
Chuck
"Even supernovas have their duller moments."

