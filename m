Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314417AbSDRSwr>; Thu, 18 Apr 2002 14:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314420AbSDRSwq>; Thu, 18 Apr 2002 14:52:46 -0400
Received: from air-2.osdl.org ([65.201.151.6]:47121 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S314417AbSDRSwp> convert rfc822-to-8bit;
	Thu, 18 Apr 2002 14:52:45 -0400
Date: Thu, 18 Apr 2002 11:48:35 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Anthony Chee <anthony.chee@polyu.edu.hk>
cc: =?iso-8859-1?Q?Peter_W=E4chtler?= <pwaechtler@loewe-komp.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: read proc entry
In-Reply-To: <002001c1e2f4$983f7e00$0100a8c0@winxp>
Message-ID: <Pine.LNX.4.33L2.0204181121000.11734-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Another thing that you could do is use the seq_file
interface for proc-fs.  That should do away with
the EOF/double-read problem.

seq_file is available in kernel 2.4.15 and later.

~Randy

On Sat, 13 Apr 2002, Anthony Chee wrote:

| After I added *eof =1, that message appears two times. How can I reduce it
| only one?
|
| ----- Original Message -----
| From: "Peter Wächtler" <pwaechtler@loewe-komp.de>
| To: "Anthony Chee" <anthony.chee@polyu.edu.hk>
| Cc: <linux-kernel@vger.kernel.org>
| Sent: Saturday, April 13, 2002 9:58 PM
| Subject: Re: read proc entry
|
|
| > Anthony Chee wrote:
| > >
| > > I written the following code in a module
| > >
| > > static struct proc_dir_entry *test_proc;
| > > test_proc = create_proc_read_entry(test_proc, 0444, NULL,
| read_test_proc,
| > > NULL);
| > >
| > > void show_kernel_message() {
| > >     printk("\nkernel test\n");
| > > }
| > >
| > > int read_test_info(char* page, char** start, off_t off, int count, int*
| eof,
| > > void* data) {
| > >     show_kernel_message();
| >
| > I think you have to signal EOF
| >
| > *eof=1;
| >
| > > }
| > >
| > > After I use "cat /proc/test_proc", it is found that there are three
| "kernel
| > > test" messages
| > > appear. Why it happened like this? I expected the message should be
| shown
| > > once.
| > >
| >
| -

