Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbTISGIq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 02:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbTISGIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 02:08:46 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:39349 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S261356AbTISGIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 02:08:44 -0400
Date: Thu, 18 Sep 2003 23:07:19 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: hugang@soulinfo.com
Subject: [Bug 1249] New: use O_DIRECT open file,	when read will hang. 
Message-ID: <261340000.1063951639@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1249

           Summary: use O_DIRECT open file, when read will hang.
    Kernel Version: 2.6.0-test5-mm2
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: hugang@soulinfo.com


Steps to reproduce:

rm -f /tmp/1.log
touch /tmp/1.log
echo << EOF > /tmp/hang.c 
# include <sys/types.h>
# include <asm/fcntl.h>

main()
{
        int i;
        char buf[1025];

        i = open("/tmp/1.log", O_RDONLY | 040000, 0);
        if ( i != -1) {
                read(i, buf, 1);
        }
        printf("'%s'", buf);
}
EOF
gcc -o /tmp/hang /tmp/hang.c
/tmp/hang


