Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292650AbSBZSXd>; Tue, 26 Feb 2002 13:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292420AbSBZSWr>; Tue, 26 Feb 2002 13:22:47 -0500
Received: from [213.188.83.99] ([213.188.83.99]:46926 "EHLO lsinitam")
	by vger.kernel.org with ESMTP id <S292650AbSBZSUi> convert rfc822-to-8bit;
	Tue, 26 Feb 2002 13:20:38 -0500
Content-Type: text/plain; charset=US-ASCII
From: Laurent <laurent@augias.org>
To: linux-kernel@vger.kernel.org
Subject: read_proc issue
Date: Tue, 26 Feb 2002 19:21:16 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16fmE1-0000Mu-00@lsinitam>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone, hope I don't disturb too much.

I'm developping a module which uses an entry in /proc (read-only)
Currently my (*read_proc) function just write a integer in my /proc entry  
and increments it. Here is the code:

static int number_read_procmem(char *buf, char **start, off_t offset, int 
count, int *eof, void *data)
{
        int len = 0;

        len = sprintf(buf, "%d\n", number_current++);
        *eof = 1;
        return len;
}

the function is registered in init_module with this:
create_proc_read_entry("number", 0, NULL, number_read_procmem, NULL);

Problem is:
when I 'cat /proc/number' multiple times, instead of getting
0
1
2
3
...

I get
0
2
4
6
...

I've searched the Net for an answer to this but in vain. I'm not sure I 
should post this to this list (and I'm very sorry if I indeed shouldn't have) 
but this list is my last hope :(

Please can you CC: me the answers to this post as I'm not on the list.
Then again, sorry if I'm intruding and thanks for any help.

Regards,
Laurent Sinitambirivoutin
laurent@augias.org
