Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310570AbSCMNRJ>; Wed, 13 Mar 2002 08:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310573AbSCMNRA>; Wed, 13 Mar 2002 08:17:00 -0500
Received: from mail.spylog.com ([194.67.35.220]:7881 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S310570AbSCMNQu>;
	Wed, 13 Mar 2002 08:16:50 -0500
Date: Wed, 13 Mar 2002 16:17:18 +0300
From: Peter Zaitsev <pz@spylog.ru>
X-Mailer: The Bat! (v1.53d)
Reply-To: Peter Zaitsev <pz@spylog.ru>
Organization: SpyLOG
X-Priority: 3 (Normal)
Message-ID: <861732271654.20020313161718@spylog.ru>
To: linux-kernel@vger.kernel.org
Subject: MMAP vs READ/WRITE
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux-kernel,

 wrote you about possibilities of using MMAP in performing I/O.
  So I decided to check if it really gives any benefit under Linux. I
  used stock system (IDE PIII-500, 768M RAM) and 2.4.19pre1aa1

  I've tested 2 file sizes - 200M and 2000M to see how the fact
  content fits to cache will affect the performance.  I used 1Kb
  blocks to have it the same as MYISAM uses for keycache.
  There were two tests. One is to read file convent sequentially and
  other was to random I/O  - read and write to random locations in
  1K sizes.  The reads/writes was it 50/50 proportion. The number of
  random IOs was 10000.  File system used was EXT3.
  Before each test the cache was brought to stable state by
  "cat test.dat > /dev/null"
  

  2000M
    Test         Time Best     Time Worst    User time    System time
  Seq. read()    1m28.706s     2m20.358s     0m0.920s     0m26.550s
  Seq  mmap()    2m4.718s      4m41.674s     0m8.100s     0m11.040s
  Rnd  read()    1m49.413s     2m46.212s     0m0.010s     0m0.470s
  Rnd  mmap()    1m17.349s     2m13.482s     0m0.070s     0m0.430s


  200M
    Test         Time Best     Time Worst    User time    System time
  Seq. read()    0m1.465s      0m1.481s      0m0.050s     0m1.290s
  Seq  mmap()    0m1.206s      0m1.518s      0m0.980s     0m0.130s
  Rnd  read()    0m0.130s      0m0.134s      0m0.020s     0m0.100s
  Rnd  mmap()    0m0.079s      0m0.082s      0m0.050s     0m0.020s
  


  2000M 4K block  (to compare)
  Test         Time Best     Time Worst     User time    System time
  Seq. read()    1m28.328s     2m11.609s     0m0.260s     0m23.510s
  Seq  mmap()    2m32.768s     4m28.321s     0m8.090s     0m11.240s
  Rnd  read()    1m6.351s      1m46.149s     0m0.040s     0m0.400s
  Rnd  mmap()    1m10.707s     1m57.281s     0m0.280s     0m0.510s
    



  200M  32 byte block (to compare)
    Test         Time Best     Time Worst    User time    System time
  Seq. read()    0m8.076s      0m9.404s      0m1.730s     0m6.620s
  Seq  mmap()    0m1.227s      0m1.237s      0m1.140s     0m0.080s
  Rnd  read()    0m0.074s      0m0.085s      0m0.010s     0m0.070s
  Rnd  mmap()    0m0.029s      0m0.030s      0m0.010s     0m0.020s


  
  So I would say mmap is not really optimized nowdays in Linux and so
  read() may be wining in cases it should not. May be read-ahead is
  used with read and is not used with mmap.
  


  P.S if you're interested I can send you complete source

    

-- 
Best regards,
 Peter                          mailto:pz@spylog.ru

