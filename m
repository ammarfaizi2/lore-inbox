Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129538AbRAFErU>; Fri, 5 Jan 2001 23:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129771AbRAFErL>; Fri, 5 Jan 2001 23:47:11 -0500
Received: from c-025.static.AT.KPNQwest.net ([193.154.188.25]:50417 "EHLO
	stefan.sime.com") by vger.kernel.org with ESMTP id <S129538AbRAFEqv>;
	Fri, 5 Jan 2001 23:46:51 -0500
Date: Sat, 6 Jan 2001 05:46:15 +0100
From: Stefan Traby <stefan@hello-penguin.com>
To: linux-kernel@vger.kernel.org
Subject: ramfs problem... (unlink of sparse file in "D" state)
Message-ID: <20010106054615.A2958@stefan.sime.com>
Reply-To: Stefan Traby <stefan@hello-penguin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Stefan Traby Services && Consulting
X-Operating-System: Linux 2.4.0-fijiji0 (i686)
X-APM: 100% 400 min
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I create a sparse file on ramfs (by writing 5 bytes at offset 3GB):

0.000269 open("./lfs.file", O_RDWR|O_CREAT|O_TRUNC|O_LARGEFILE, 0600) = 3
0.000214 _llseek(3, 18446744072635809792, [3221225472], SEEK_SET) = 0           
0.000159 write(3, "hallo", 5)      = 5                                          
0.000176 close(3)                  = 0                                          
0.000166 _exit(0)                  = ?                                          

Works fine.

Then I tried to unlink the file by running rm lfs.file log.

The rm process (and an ls process that I started after that)
are now in "D" state...

root      2934  0.0  0.2  1292  452 pts/5    D    05:38   0:00 ls /ramfs
root      2952  0.0  1.5  4028 2384 pts/3    S    05:40   0:00 vi sdlkhfd


(Note that the ls hangs because of "rm". before running "rm" ls worked
 fine. The same test (including rm) works fine on reiserfs 3.6.24 on
 the same 2.4.0 release kernel. But reiserfs needed 34 seconds on close
 and the system was not very responsible (including mouse updates within X)
 for that time....)


-- 

  ciao - 
    Stefan

"     ( cd /lib ; ln -s libBrokenLocale-2.2.so libNiedersachsen.so )     "
    
Stefan Traby                Linux/ia32               fax:  +43-3133-6107-9
Mitterlasznitzstr. 13       Linux/alpha            phone:  +43-3133-6107-2
8302 Nestelbach             Linux/sparc       http://www.hello-penguin.com
Austria                                    mailto://st.traby@opengroup.org
Europe                                   mailto://stefan@hello-penguin.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
