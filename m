Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030623AbWKUIYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030623AbWKUIYn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 03:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030729AbWKUIYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 03:24:43 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:15816 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030623AbWKUIYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 03:24:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=H8U+pOP2xsjohA7lWzI03q9SsjUE2Ev/MKSV4NXuJTeJ/5agenBWVHvfuZVVFtn6ci6wtrmcHm81pLk2RErFFUDOCcw1SAx91r3FMvmERZD6Zqsgaj1DCH5gqojKkDpqIz8RbRngUg8fE13+4Zbsyc4IVj695MiFCp7OgVY9z/s=
Message-ID: <92cbf19b0611210024j3c1e2c6cr4b6d47ed6aaf2925@mail.gmail.com>
Date: Tue, 21 Nov 2006 00:24:40 -0800
From: "Chakri n" <chakriin5@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel panic in cifs_revalidate
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am seeing a kernel panic in cifs module. It seems to be a result of
invalid inode entry in dentry for the file it is trying to validate.

The inode->i_ino is set zero and inode->i_mapping is set to NULL in
the inode pointer in the dentry (0xdf8ea200) structure. I went through
the cifs code and could not find any valid case that could trigger
this situation. Is there any case which can lead to this situation?

0xed47fe70 0xc0133b30 filemap_fdatawait+0x20 (0x0, 0xe0e1c780, 0x0,
0xf5b35000, 0x0)
                               kernel .text 0xc0100000 0xc0133b10 0xc0133bc0
0xed47feb8 0xf8b49855 [cifs]cifs_revalidate+0x225 (0xdf8ea200)
                               cifs .text 0xf8b27060 0xf8b49630 0xf8b49af0
0xed47fec4 0xf8b3ec71 [cifs]cifs_d_revalidate+0x11 (0xdf8ea200, 0x0, 0xef47a031)
                               cifs .text 0xf8b27060 0xf8b3ec60 0xf8b3ec7d
0xed47fed8 0xc0151c03 cached_lookup+0x43 (0xe8e03a00, 0xed47fefc, 0x0,
0x1, 0xe7f5b0f8)
                               kernel .text 0xc0100000 0xc0151bc0 0xc0151c20
0xed47ff18 0xc01522a8 link_path_walk+0x3e8
                               kernel .text 0xc0100000 0xc0151ec0 0xc0152610
0xed47ff20 0xc0152629 path_walk+0x19 (0x8002, 0x8003, 0x83141a0)
                               kernel .text 0xc0100000 0xc0152610 0xc0152630
0xed47ff34 0xc015280a path_lookup+0x3a (0x0, 0x0, 0x2, 0x0, 0x0)
                               kernel .text 0xc0100000 0xc01527d0 0xc0152810
0xed47ff64 0xc0152d3a open_namei+0x6a (0xef47a000, 0x8003, 0x0,
0xed47ff7c, 0xe8e03a00)
                               kernel .text 0xc0100000 0xc0152cd0 0xc0153260
0xed47ffa0 0xc01448b1 filp_open+0x41 (0xef47a000, 0x8002, 0x0,
0xed47e000, 0x8002)
                               kernel .text 0xc0100000 0xc0144870 0xc01448e0
0xed47ffbc 0xc0144ca1 sys_open+0x51 (0x83141a0, 0x8002, 0x0, 0x8002, 0x83141a0)

Thanks
--Chakri
