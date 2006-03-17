Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750895AbWCQMNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbWCQMNE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 07:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbWCQMNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 07:13:04 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:23559 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750895AbWCQMND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 07:13:03 -0500
Date: Fri, 17 Mar 2006 13:13:30 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: albert@users.sourceforge.net
Cc: ihno@suse.de, hare@suse.de, peter.oberparleiter@de.ibm.com,
       jan.glauber@de.ibm.com, paulus@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cputime support for procps.
Message-ID: <20060317121329.GA6132@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Albert,
according to the sourceforge web site you are the maintainer for
procps. I have a procps patch that introduces a new field to top
and vmstat. It has been lying around on my disk for too long now
and before it rots any further I'm sending it to you for
integration. The background is the cputime concept for virtual
systems that has been added to 2.6.11. So far only s390 had a
use for it, but lately powerpc joined the club. They will
probably need the steal time field in the top/vmstat output in
the near future as well. One of my concerns is the limitation of
the output to 80 characters. I had to squeeze the fields to make
it all fit into a single line. I hope that the new look it still
acceptable.

Could you take a look at this?

blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.
---

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[patch] procps: add cpu steal time fields vmstat and top.

Make use of the cpu steal time field in /proc/stat that has been
introduced by the cputime patch with kernel version 2.6.11. The new
output of top looks like this:

top - 09:50:20 up 11 min,  3 users,  load average: 8.94, 7.17, 3.82
Tasks:  78 total,   8 running,  70 sleeping,   0 stopped,   0 zombie
 Cpu0 : 38.7%us,  4.2%sy,  0.0%ni,  0.0%id,  2.4%wa,  1.8%hi,  0.0%si, 53.0%st
 Cpu1 : 38.5%us,  0.6%sy,  0.0%ni,  5.1%id,  1.3%wa,  1.9%hi,  0.0%si, 52.6%st
 Cpu2 : 54.0%us,  0.6%sy,  0.0%ni,  0.6%id,  4.9%wa,  1.2%hi,  0.0%si, 38.7%st
 Cpu3 : 49.1%us,  0.6%sy,  0.0%ni,  1.2%id,  0.0%wa,  0.0%hi,  0.0%si, 49.1%st
 Cpu4 : 35.9%us,  1.2%sy,  0.0%ni, 15.0%id,  0.6%wa,  1.8%hi,  0.0%si, 45.5%st
 Cpu5 : 43.0%us,  2.1%sy,  0.7%ni,  0.0%id,  4.2%wa,  1.4%hi,  0.0%si, 48.6%st
Mem:    251832k total,   155448k used,    96384k free,     1212k buffers
Swap:   524248k total,    17716k used,   506532k free,    18096k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
20629 root      25   0 30572  27m 7076 R 55.2 11.1   0:02.14 cc1
20617 root      25   0 40600  37m 7076 R 47.0 15.1   0:03.04 cc1
20635 root      24   0 26356  20m 7076 R 42.3  8.4   0:00.75 cc1
20638 root      25   0 23196  17m 7076 R 27.0  7.2   0:00.46 cc1
20642 root      25   0 15028 9824 7076 R 18.2  3.9   0:00.31 cc1
20644 root      20   0 14852 9648 7076 R 17.0  3.8   0:00.29 cc1
   26 root       5 -10     0    0    0 S  0.6  0.0   0:00.03 kblockd/5
  915 root      16   0  3012  884 2788 R  0.6  0.4   0:02.33 top
    1 root      16   0  2020  284 1844 S  0.0  0.1   0:00.06 init

and the output of vmstat looks like this:

procs -----------memory---------- ---swap-- -----io---- -system-- -----cpu------
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
 6  0      0  47416  22024 103296    0    0     0     0  564  195 63  7  8  0 22
 6  0      0  46128  22060 104300    0    0     0   308  598  181 65  6  8  0 21
 7  0      0  34096  22088 104012    0    0     0     0  608  103 68  6  1  0 25
 6  0      0  12336  22108 104512    0    0     0  2628  628  160 68  3  3  3 23
 6  0      0  26544  22124 105016    0    0     0     0  588   99 69  4  3  0 23
 6  0      0  19744  22148 105252    0    0     0     0  600  192 64  6  5  0 25
 6  0      0  27768  22192 105468    0    0     0   548  619  174 67  5  3  0 25
 7  0      0  37168  22216 106484    0    0     0     0  561  117 67  6  8  0 19

The patch has been created against the CVS version of procps dated 05/03/2006.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 proc/sysinfo.c |   27 +++++++++++++++++----------
 proc/sysinfo.h |    4 ++--
 top.c          |   22 +++++++++++++++-------
 top.h          |    6 ++++--
 vmstat.8       |    1 +
 vmstat.c       |   39 +++++++++++++++++++++++----------------
 6 files changed, 62 insertions(+), 37 deletions(-)

diff -urpN procps/proc/sysinfo.c procps-cputime/proc/sysinfo.c
--- procps/proc/sysinfo.c	2006-03-05 19:29:10.000000000 +0100
+++ procps-cputime/proc/sysinfo.c	2006-03-05 19:41:10.000000000 +0100
@@ -238,11 +238,11 @@ static void init_libproc(void){
 #define NAN (-0.0)
 #endif
 #define JT unsigned long long
-void seven_cpu_numbers(double *restrict uret, double *restrict nret, double *restrict sret, double *restrict iret, double *restrict wret, double *restrict xret, double *restrict yret){
-    double tmp_u, tmp_n, tmp_s, tmp_i, tmp_w, tmp_x, tmp_y;
+void eight_cpu_numbers(double *restrict uret, double *restrict nret, double *restrict sret, double *restrict iret, double *restrict wret, double *restrict xret, double *restrict yret, double *restrict zret){
+    double tmp_u, tmp_n, tmp_s, tmp_i, tmp_w, tmp_x, tmp_y, tmp_z;
     double scale;  /* scale values to % */
-    static JT old_u, old_n, old_s, old_i, old_w, old_x, old_y;
-    JT new_u, new_n, new_s, new_i, new_w, new_x, new_y;
+    static JT old_u, old_n, old_s, old_i, old_w, old_x, old_y, old_z;
+    JT new_u, new_n, new_s, new_i, new_w, new_x, new_y, new_z;
     JT ticks_past; /* avoid div-by-0 by not calling too often :-( */
 
     tmp_w = 0.0;
@@ -251,10 +251,12 @@ void seven_cpu_numbers(double *restrict 
     new_x = 0;
     tmp_y = 0.0;
     new_y = 0;
+    tmp_z = 0.0;
+    new_z = 0;
  
     FILE_TO_BUF(STAT_FILE,stat_fd);
-    sscanf(buf, "cpu %Lu %Lu %Lu %Lu %Lu %Lu %Lu", &new_u, &new_n, &new_s, &new_i, &new_w, &new_x, &new_y);
-    ticks_past = (new_u+new_n+new_s+new_i+new_w+new_x+new_y)-(old_u+old_n+old_s+old_i+old_w+old_x+old_y);
+    sscanf(buf, "cpu %Lu %Lu %Lu %Lu %Lu %Lu %Lu %Lu", &new_u, &new_n, &new_s, &new_i, &new_w, &new_x, &new_y, &new_z);
+    ticks_past = (new_u+new_n+new_s+new_i+new_w+new_x+new_y+new_z)-(old_u+old_n+old_s+old_i+old_w+old_x+old_y+old_z);
     if(ticks_past){
       scale = 100.0 / (double)ticks_past;
       tmp_u = ( (double)new_u - (double)old_u ) * scale;
@@ -264,6 +266,7 @@ void seven_cpu_numbers(double *restrict 
       tmp_w = ( (double)new_w - (double)old_w ) * scale;
       tmp_x = ( (double)new_x - (double)old_x ) * scale;
       tmp_y = ( (double)new_y - (double)old_y ) * scale;
+      tmp_z = ( (double)new_z - (double)old_z ) * scale;
     }else{
       tmp_u = NAN;
       tmp_n = NAN;
@@ -272,14 +275,16 @@ void seven_cpu_numbers(double *restrict 
       tmp_w = NAN;
       tmp_x = NAN;
       tmp_y = NAN;
+      tmp_z = NAN;
     }
     SET_IF_DESIRED(uret, tmp_u);
     SET_IF_DESIRED(nret, tmp_n);
     SET_IF_DESIRED(sret, tmp_s);
     SET_IF_DESIRED(iret, tmp_i);
     SET_IF_DESIRED(wret, tmp_w);
-    SET_IF_DESIRED(iret, tmp_x);
-    SET_IF_DESIRED(wret, tmp_y);
+    SET_IF_DESIRED(xret, tmp_x);
+    SET_IF_DESIRED(yret, tmp_y);
+    SET_IF_DESIRED(zret, tmp_z);
     old_u=new_u;
     old_n=new_n;
     old_s=new_s;
@@ -287,6 +292,7 @@ void seven_cpu_numbers(double *restrict 
     old_w=new_w;
     old_i=new_x;
     old_w=new_y;
+    old_z=new_z;
 }
 #undef JT
 #endif
@@ -361,7 +367,7 @@ static void getrunners(unsigned int *res
 
 /***********************************************************************/
 
-void getstat(jiff *restrict cuse, jiff *restrict cice, jiff *restrict csys, jiff *restrict cide, jiff *restrict ciow, jiff *restrict cxxx, jiff *restrict cyyy,
+void getstat(jiff *restrict cuse, jiff *restrict cice, jiff *restrict csys, jiff *restrict cide, jiff *restrict ciow, jiff *restrict cxxx, jiff *restrict cyyy, jiff *restrict czzz,
 	     unsigned long *restrict pin, unsigned long *restrict pout, unsigned long *restrict s_in, unsigned long *restrict sout,
 	     unsigned *restrict intr, unsigned *restrict ctxt,
 	     unsigned int *restrict running, unsigned int *restrict blocked,
@@ -384,9 +390,10 @@ void getstat(jiff *restrict cuse, jiff *
   *ciow = 0;  /* not separated out until the 2.5.41 kernel */
   *cxxx = 0;  /* not separated out until the 2.6.0-test4 kernel */
   *cyyy = 0;  /* not separated out until the 2.6.0-test4 kernel */
+  *czzz = 0;  /* not separated out until the 2.6.11 kernel */
 
   b = strstr(buff, "cpu ");
-  if(b) sscanf(b,  "cpu  %Lu %Lu %Lu %Lu %Lu %Lu %Lu", cuse, cice, csys, cide, ciow, cxxx, cyyy);
+  if(b) sscanf(b,  "cpu  %Lu %Lu %Lu %Lu %Lu %Lu %Lu %Lu", cuse, cice, csys, cide, ciow, cxxx, cyyy, czzz);
 
   b = strstr(buff, "page ");
   if(b) sscanf(b,  "page %lu %lu", pin, pout);
diff -urpN procps/proc/sysinfo.h procps-cputime/proc/sysinfo.h
--- procps/proc/sysinfo.h	2006-03-05 19:29:10.000000000 +0100
+++ procps-cputime/proc/sysinfo.h	2006-03-05 19:41:49.000000000 +0100
@@ -12,7 +12,7 @@ extern int have_privs;     /* boolean, t
 
 #if 0
 #define JT double
-extern void seven_cpu_numbers(JT *uret, JT *nret, JT *sret, JT *iret, JT *wret, JT *xret, JT *yret);
+extern void eight_cpu_numbers(JT *uret, JT *nret, JT *sret, JT *iret, JT *wret, JT *xret, JT *yret);
 #undef JT
 #endif
 
@@ -56,7 +56,7 @@ extern unsigned long kb_pagetables;
 
 #define BUFFSIZE (64*1024)
 typedef unsigned long long jiff;
-extern void getstat(jiff *restrict cuse, jiff *restrict cice, jiff *restrict csys, jiff *restrict cide, jiff *restrict ciow, jiff *restrict cxxx, jiff *restrict cyyy,
+extern void getstat(jiff *restrict cuse, jiff *restrict cice, jiff *restrict csys, jiff *restrict cide, jiff *restrict ciow, jiff *restrict cxxx, jiff *restrict cyyy, jiff *restrict czzz,
 	     unsigned long *restrict pin, unsigned long *restrict pout, unsigned long *restrict s_in, unsigned long *restrict sout,
 	     unsigned *restrict intr, unsigned *restrict ctxt,
 	     unsigned int *restrict running, unsigned int *restrict blocked,
diff -urpN procps/top.c procps-cputime/top.c
--- procps/top.c	2006-03-05 19:29:10.000000000 +0100
+++ procps-cputime/top.c	2006-03-05 19:44:55.000000000 +0100
@@ -932,14 +932,16 @@ static CPU_t *cpus_refresh (CPU_t *cpus)
    if (!fgets(buf, sizeof(buf), fp)) std_err("failed /proc/stat read");
    cpus[Cpu_tot].x = 0;  // FIXME: can't tell by kernel version number
    cpus[Cpu_tot].y = 0;  // FIXME: can't tell by kernel version number
-   num = sscanf(buf, "cpu %Lu %Lu %Lu %Lu %Lu %Lu %Lu",
+   cpus[Cpu_tot].z = 0;  // FIXME: can't tell by kernel version number
+   num = sscanf(buf, "cpu %Lu %Lu %Lu %Lu %Lu %Lu %Lu %Lu",
       &cpus[Cpu_tot].u,
       &cpus[Cpu_tot].n,
       &cpus[Cpu_tot].s,
       &cpus[Cpu_tot].i,
       &cpus[Cpu_tot].w,
       &cpus[Cpu_tot].x,
-      &cpus[Cpu_tot].y
+      &cpus[Cpu_tot].y,
+      &cpus[Cpu_tot].z
    );
    if (num < 4)
          std_err("failed /proc/stat read");
@@ -955,9 +957,10 @@ static CPU_t *cpus_refresh (CPU_t *cpus)
       if (!fgets(buf, sizeof(buf), fp)) std_err("failed /proc/stat read");
       cpus[i].x = 0;  // FIXME: can't tell by kernel version number
       cpus[i].y = 0;  // FIXME: can't tell by kernel version number
-      num = sscanf(buf, "cpu%u %Lu %Lu %Lu %Lu %Lu %Lu %Lu",
+      cpus[i].z = 0;  // FIXME: can't tell by kernel version number
+      num = sscanf(buf, "cpu%u %Lu %Lu %Lu %Lu %Lu %Lu %Lu %Lu",
          &cpus[i].id,
-         &cpus[i].u, &cpus[i].n, &cpus[i].s, &cpus[i].i, &cpus[i].w, &cpus[i].x, &cpus[i].y
+         &cpus[i].u, &cpus[i].n, &cpus[i].s, &cpus[i].i, &cpus[i].w, &cpus[i].x, &cpus[i].y, &cpus[i].z
       );
       if (num < 4)
             std_err("failed /proc/stat read");
@@ -1599,6 +1602,8 @@ static void before (char *me)
       States_fmts = STATES_line2x5;
    if (linux_version_code >= LINUX_VERSION(2, 6, 0))  // grrr... only some 2.6.0-testX :-(
       States_fmts = STATES_line2x6;
+   if (linux_version_code >= LINUX_VERSION(2, 6, 11))
+      States_fmts = STATES_line2x7;
 
       /* get virtual page size -- nearing huge! */
    Page_size = getpagesize();
@@ -2861,7 +2866,7 @@ static void summaryhlp (CPU_t *cpu, cons
    // we'll trim to zero if we get negative time ticks,
    // which has happened with some SMP kernels (pre-2.4?)
 #define TRIMz(x)  ((tz = (SIC_t)(x)) < 0 ? 0 : tz)
-   SIC_t u_frme, s_frme, n_frme, i_frme, w_frme, x_frme, y_frme, tot_frme, tz;
+   SIC_t u_frme, s_frme, n_frme, i_frme, w_frme, x_frme, y_frme, z_frme, tot_frme, tz;
    float scale;
 
    u_frme = cpu->u - cpu->u_sav;
@@ -2871,7 +2876,8 @@ static void summaryhlp (CPU_t *cpu, cons
    w_frme = cpu->w - cpu->w_sav;
    x_frme = cpu->x - cpu->x_sav;
    y_frme = cpu->y - cpu->y_sav;
-   tot_frme = u_frme + s_frme + n_frme + i_frme + w_frme + x_frme + y_frme;
+   z_frme = cpu->z - cpu->z_sav;
+   tot_frme = u_frme + s_frme + n_frme + i_frme + w_frme + x_frme + y_frme + z_frme;
    if (tot_frme < 1) tot_frme = 1;
    scale = 100.0 / (float)tot_frme;
 
@@ -2888,7 +2894,8 @@ static void summaryhlp (CPU_t *cpu, cons
          (float)i_frme * scale,
          (float)w_frme * scale,
          (float)x_frme * scale,
-         (float)y_frme * scale
+         (float)y_frme * scale,
+         (float)z_frme * scale
       )
    );
    Msg_row += 1;
@@ -2901,6 +2908,7 @@ static void summaryhlp (CPU_t *cpu, cons
    cpu->w_sav = cpu->w;
    cpu->x_sav = cpu->x;
    cpu->y_sav = cpu->y;
+   cpu->z_sav = cpu->z;
 
 #undef TRIMz
 }
diff -urpN procps/top.h procps-cputime/top.h
--- procps/top.h	2006-03-05 19:29:10.000000000 +0100
+++ procps-cputime/top.h	2006-03-05 19:44:19.000000000 +0100
@@ -211,8 +211,8 @@ typedef struct HST_t {
 // calculations.  It exists primarily for SMP support but serves
 // all environments.
 typedef struct CPU_t {
-   TIC_t u, n, s, i, w, x, y;                             // as represented in /proc/stat
-   TIC_t u_sav, s_sav, n_sav, i_sav, w_sav, x_sav, y_sav; // in the order of our display
+   TIC_t u, n, s, i, w, x, y, z; // as represented in /proc/stat
+   TIC_t u_sav, s_sav, n_sav, i_sav, w_sav, x_sav, y_sav, z_sav; // in the order of our display
    unsigned id;  // the CPU ID number
 } CPU_t;
 
@@ -389,6 +389,8 @@ typedef struct WIN_t {
    " %#5.1f%% \02user,\03 %#5.1f%% \02system,\03 %#5.1f%% \02nice,\03 %#5.1f%% \02idle,\03 %#5.1f%% \02IO-wait\03\n"
 #define STATES_line2x6  "%s\03" \
    " %#4.1f%% \02us,\03 %#4.1f%% \02sy,\03 %#4.1f%% \02ni,\03 %#4.1f%% \02id,\03 %#4.1f%% \02wa,\03 %#4.1f%% \02hi,\03 %#4.1f%% \02si\03\n"
+#define STATES_line2x7  "%s\03" \
+   "%#5.1f%%\02us,\03%#5.1f%%\02sy,\03%#5.1f%%\02ni,\03%#5.1f%%\02id,\03%#5.1f%%\02wa,\03%#5.1f%%\02hi,\03%#5.1f%%\02si,\03%#5.1f%%\02st\03\n"
 #ifdef CASEUP_SUMMK
 #define MEMORY_line1  "Mem: \03" \
    " %8uK \02total,\03 %8uK \02used,\03 %8uK \02free,\03 %8uK \02buffers\03\n"
diff -urpN procps/vmstat.8 procps-cputime/vmstat.8
--- procps/vmstat.8	2003-08-11 01:40:41.000000000 +0200
+++ procps-cputime/vmstat.8	2006-03-05 19:30:14.000000000 +0100
@@ -114,6 +114,7 @@ us: Time spent running non-kernel code. 
 sy: Time spent running kernel code. (system time)
 id: Time spent idle. Prior to Linux 2.5.41, this includes IO-wait time.
 wa: Time spent waiting for IO. Prior to Linux 2.5.41, shown as zero.
+st: Time spent in involuntary wait. Prior to Linux 2.6.11, shown as zero.
 
 .PP
 .SH FIELD DESCRIPTION FOR DISK MODE 
diff -urpN procps/vmstat.c procps-cputime/vmstat.c
--- procps/vmstat.c	2006-03-05 19:29:10.000000000 +0100
+++ procps-cputime/vmstat.c	2006-03-05 19:30:14.000000000 +0100
@@ -150,15 +150,15 @@ static int format_1000(unsigned long lon
 ////////////////////////////////////////////////////////////////////////////
 
 static void new_header(void){
-  printf("procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----\n");
+  printf("procs -----------memory---------- ---swap-- -----io---- -system-- -----cpu------\n");
   printf(
-    "%2s %2s %6s %6s %6s %6s %4s %4s %5s %5s %4s %5s %2s %2s %2s %2s\n",
+    "%2s %2s %6s %6s %6s %6s %4s %4s %5s %5s %4s %4s %2s %2s %2s %2s %2s\n",
     "r","b",
     "swpd", "free", a_option?"inact":"buff", a_option?"active":"cache",
     "si","so",
     "bi","bo",
     "in","cs",
-    "us","sy","id","wa"
+    "us","sy","id","wa", "st"
   );
 }
 
@@ -173,13 +173,13 @@ static unsigned long unitConvert(unsigne
 ////////////////////////////////////////////////////////////////////////////
 
 static void new_format(void) {
-  const char format[]="%2u %2u %6lu %6lu %6lu %6lu %4u %4u %5u %5u %4u %5u %2u %2u %2u %2u\n";
+  const char format[]="%2u %2u %6lu %6lu %6lu %6lu %4u %4u %5u %5u %4u %4u %2u %2u %2u %2u %2u\n";
   unsigned int tog=0; /* toggle switch for cleaner code */
   unsigned int i;
   unsigned int hz = Hertz;
   unsigned int running,blocked,dummy_1,dummy_2;
-  jiff cpu_use[2], cpu_nic[2], cpu_sys[2], cpu_idl[2], cpu_iow[2], cpu_xxx[2], cpu_yyy[2];
-  jiff duse, dsys, didl, diow, Div, divo2;
+  jiff cpu_use[2], cpu_nic[2], cpu_sys[2], cpu_idl[2], cpu_iow[2], cpu_xxx[2], cpu_yyy[2], cpu_zzz[2];
+  jiff duse, dsys, didl, diow, dstl, Div, divo2;
   unsigned long pgpgin[2], pgpgout[2], pswpin[2], pswpout[2];
   unsigned int intr[2], ctxt[2];
   unsigned int sleep_half; 
@@ -190,7 +190,7 @@ static void new_format(void) {
   new_header();
   meminfo();
 
-  getstat(cpu_use,cpu_nic,cpu_sys,cpu_idl,cpu_iow,cpu_xxx,cpu_yyy,
+  getstat(cpu_use,cpu_nic,cpu_sys,cpu_idl,cpu_iow,cpu_xxx,cpu_yyy,cpu_zzz,
 	  pgpgin,pgpgout,pswpin,pswpout,
 	  intr,ctxt,
 	  &running,&blocked,
@@ -200,7 +200,8 @@ static void new_format(void) {
   dsys= *cpu_sys + *cpu_xxx + *cpu_yyy;
   didl= *cpu_idl;
   diow= *cpu_iow;
-  Div= duse+dsys+didl+diow;
+  dstl= *cpu_zzz;
+  Div= duse+dsys+didl+diow+dstl;
   divo2= Div/2UL;
   printf(format,
 	 running, blocked,
@@ -216,7 +217,8 @@ static void new_format(void) {
 	 (unsigned)( (100*duse                    + divo2) / Div ),
 	 (unsigned)( (100*dsys                    + divo2) / Div ),
 	 (unsigned)( (100*didl                    + divo2) / Div ),
-	 (unsigned)( (100*diow                    + divo2) / Div )
+	 (unsigned)( (100*diow                    + divo2) / Div ),
+	 (unsigned)( (100*dstl                    + divo2) / Div )
   );
 
   for(i=1;i<num_updates;i++) { /* \\\\\\\\\\\\\\\\\\\\ main loop ////////////////// */
@@ -226,7 +228,7 @@ static void new_format(void) {
 
     meminfo();
 
-    getstat(cpu_use+tog,cpu_nic+tog,cpu_sys+tog,cpu_idl+tog,cpu_iow+tog,cpu_xxx+tog,cpu_yyy+tog,
+    getstat(cpu_use+tog,cpu_nic+tog,cpu_sys+tog,cpu_idl+tog,cpu_iow+tog,cpu_xxx+tog,cpu_yyy+tog,cpu_zzz+tog,
 	  pgpgin+tog,pgpgout+tog,pswpin+tog,pswpout+tog,
 	  intr+tog,ctxt+tog,
 	  &running,&blocked,
@@ -236,6 +238,7 @@ static void new_format(void) {
     dsys= cpu_sys[tog]-cpu_sys[!tog] + cpu_xxx[tog]-cpu_xxx[!tog] + cpu_yyy[tog]-cpu_yyy[!tog];
     didl= cpu_idl[tog]-cpu_idl[!tog];
     diow= cpu_iow[tog]-cpu_iow[!tog];
+    dstl= cpu_zzz[tog]-cpu_zzz[!tog];
 
     /* idle can run backwards for a moment -- kernel "feature" */
     if(debt){
@@ -247,7 +250,7 @@ static void new_format(void) {
       didl = 0;
     }
 
-    Div= duse+dsys+didl+diow;
+    Div= duse+dsys+didl+diow+dstl;
     divo2= Div/2UL;
     printf(format,
            running, blocked,
@@ -263,7 +266,8 @@ static void new_format(void) {
 	   (unsigned)( (100*duse+divo2)/Div ), /*us*/
 	   (unsigned)( (100*dsys+divo2)/Div ), /*sy*/
 	   (unsigned)( (100*didl+divo2)/Div ), /*id*/
-	   (unsigned)( (100*diow+divo2)/Div )  /*wa*/
+	   (unsigned)( (100*diow+divo2)/Div ), /*wa*/
+	   (unsigned)( (100*dstl+divo2)/Div )  /*st*/
     );
   }
 }
@@ -504,13 +508,14 @@ static void disksum_format(void) {
 
 static void sum_format(void) {
   unsigned int running, blocked, btime, processes;
-  jiff cpu_use, cpu_nic, cpu_sys, cpu_idl, cpu_iow, cpu_xxx, cpu_yyy;
+  jiff cpu_use, cpu_nic, cpu_sys, cpu_idl, cpu_iow, cpu_xxx, cpu_yyy, cpu_zzz;
   unsigned long pgpgin, pgpgout, pswpin, pswpout;
   unsigned int intr, ctxt;
 
   meminfo();
 
-  getstat(&cpu_use, &cpu_nic, &cpu_sys, &cpu_idl, &cpu_iow, &cpu_xxx, &cpu_yyy,
+  getstat(&cpu_use, &cpu_nic, &cpu_sys, &cpu_idl,
+          &cpu_iow, &cpu_xxx, &cpu_yyy, &cpu_zzz,
 	  &pgpgin, &pgpgout, &pswpin, &pswpout,
 	  &intr, &ctxt,
 	  &running, &blocked,
@@ -533,6 +538,7 @@ static void sum_format(void) {
   printf("%13Lu IO-wait cpu ticks\n", cpu_iow);
   printf("%13Lu IRQ cpu ticks\n", cpu_xxx);
   printf("%13Lu softirq cpu ticks\n", cpu_yyy);
+  printf("%13Lu steal cpu ticks\n", cpu_zzz);
   printf("%13lu pages paged in\n", pgpgin);
   printf("%13lu pages paged out\n", pgpgout);
   printf("%13lu pages swapped in\n", pswpin);
@@ -547,11 +553,12 @@ static void sum_format(void) {
 
 static void fork_format(void) {
   unsigned int running, blocked, btime, processes;
-  jiff cpu_use, cpu_nic, cpu_sys, cpu_idl, cpu_iow, cpu_xxx, cpu_yyy;
+  jiff cpu_use, cpu_nic, cpu_sys, cpu_idl, cpu_iow, cpu_xxx, cpu_yyy, cpu_zzz;
   unsigned long pgpgin, pgpgout, pswpin, pswpout;
   unsigned int intr, ctxt;
 
-  getstat(&cpu_use, &cpu_nic, &cpu_sys, &cpu_idl, &cpu_iow, &cpu_xxx, &cpu_yyy,
+  getstat(&cpu_use, &cpu_nic, &cpu_sys, &cpu_idl,
+	  &cpu_iow, &cpu_xxx, &cpu_yyy, &cpu_zzz,
 	  &pgpgin, &pgpgout, &pswpin, &pswpout,
 	  &intr, &ctxt,
 	  &running, &blocked,
